 #!/usr/bin/perl

    use strict;
    use warnings;

    # get current user 
    my $USER = getlogin || getpwuid($<) || "Kilroy";

    # Set workspace dir
    my $DIR = "/home/$USER/Downloads/";

    
    opendir(DIR, $DIR) or die $!;

    while (my $FILE = readdir(DIR)) {
        # Use a regular expression to ignore files beginning with a period
        next if ($FILE =~ m/^\./);

        # Show only files
        next unless (-f "$DIR/$FILE");

        # Use a regular expression to find files ending in .txt
        next unless ($FILE =~ m/\.pdf$/);

	print "$FILE\n";


    }

    closedir(DIR);
    exit 0;