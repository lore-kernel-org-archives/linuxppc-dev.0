Message-Id: <199903061239.MAA25819@go.hannover.sgh-net.de>
Subject: LinuxPPC after Rhapsody DR2
Date: Sat, 6 Mar 99 13:39:30 +0100
From: John L Grantham <jgrantha@hannover.sgh-net.de>
To: <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I have a question: I had Rhapsody DR2 installed on my computer at work (I 
have two G3 minitowers, one at work, one at home--at home I have LinuxPPC 
R4 installed on an internal SCSI Barracuda) and decided that I wanted to 
use Linux at work instead of Rhapsody, as we use several other Linux 
boxes (SuSE Linux) and have a lot of Linux software lying around.

On my computer at work, I have a G3/266 MT with the standard 6 GB IDE 
drive. Previously, Rhapsody occupied 800 MB on its own Titan partition 
(the rest was HFS partitions); I deleted that partition and one other 
smaller one to create 1.2 GB of space on my hard drive for LinuxPPC. 
There was one other partition marked, though, that I noticed with pdisk: 
the "Rhapsody Boot Loader". I did not delete it, but was wondering if I 
should or can. (It's not terrible, as it only occupies 1K, but I didn't 
know if it could cause problems now that Rhapsody is no longer there.)

Another oddity was that, after using BootX to install and boot LinuxPPC, 
the computer would boot in an odd fashion--briefly it would show a 
blinking question mark, then make a loud "click", then I would get a 
Happy Mac and all would go normally, until the MacOS booted fully--all of 
my icons looked _really_ weird (all in half-resolution and 
scrambled--i.e. folders had LaserWriter icons, programs had no icon, 
etc.) and the System was extremely unstable. After zapping the PRAM and 
reverting to OS 8.5, all was well again, and LinuxPPC runs totally 
normally.

As an aside, it was getting obnoxious using LinuxPPC at home, since I 
have a SPIGA ISDN and can't get it to run--meaning I can't try all the 
Net tools online. But here at work, we have a leased line, and LinuxPPC 
rocks in a LAN!

Anyway, hope you all can help clear up that problem.

Best regards,

John



John Grantham | Dipl.-Designer (FH)
              | Linux am Mac FAQ: http://linux.macnews.de/
              | Homepage: http://surf.to/multimedia


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
