 #!/usr/bin/perl

    use strict;
    use warnings;
    use File::Copy 'move';

    # get current user 
    my $USER = getlogin || getpwuid($<) || "Kilroy";

    # Set workspace dir
    my $DIR = "/home/$USER/Downloads";

    # Open working dir
    opendir(DIR, $DIR) or die $!;

    while (my $FILE = readdir(DIR)) {
        # regular expression to ignore files beginning with a period
        next if ($FILE =~ m/^\./);

        # Show only files
        next unless (-f "$DIR/$FILE");

        # regular expression to get only the extension
        my ($ext) = $FILE =~ /([^.]+)$/;

        # Run directory creation according to extensions found
        `mkdir -p $DIR/$ext`;

        # Create global source and destination
        my $SOURCE = "$DIR/$FILE";
        my $DEST = "$DIR/$ext/";

        # Move files to respective dir
        move($SOURCE,$DEST) or die "The move operation failed: $!";
    }

    closedir(DIR);
    exit 0;