 #!/usr/bin/perl -w

    use strict;
    use warnings;
    use File::Copy 'move';
    use Config;

    my $LINUX = "linux";

    if ($Config{osname} eq $LINUX) {
        # get current user 
        my $USER = getlogin || getpwuid($<) || "Kilroy";

        # Set workspace dir
        my $DIR = "/home/$USER/Downloads";

        # Open working dir
        opendir(DIR, $DIR) or die $!;

        while (my $FILE = readdir(DIR)) {
            # regular expression to ignore files beginning with a period
            next if ($FILE =~ m/^\./);

            # regular expression to skip files without extension
            next if ($FILE =~ /\w+/);

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
        print("All files moved to their respective directory. \n");
    }
    

    exit 0;