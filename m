Message-ID: <36887B5C.EC26B913@ixl.com>
Date: Tue, 29 Dec 1998 00:49:00 -0600
From: jeramy <jsmith@ixl.com>
MIME-Version: 1.0
To: Wayne Chang <wcx@iname.com>
CC: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: My pre-R5-lite
References: <v01550100b2ae04f28fb1@[207.217.233.232]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Welp, I decided to play around and try upgrading an R4 lite clean
install to glibc2 with the rpms from the pre R5 directories. I got the
comps.pmac file from the R4 lite and the comps.new from pre-5 and
compared them. I downloaded all of the RPMS from the the files
directories. And then I started laoding them in the order they are
loaded for a R4 lite install. The only exceptions were of course
libraries and compilers. Anyways, looks like im all done except for
reconfiguring X for XFB. (My fb0 dissappeared after I formatted for the
clean R4 lite install and I forgot how I made the bugger the first
time.) Also, it seems that I need to get the source RPM for XPM and
compile it as there is a pre-compiled or src.rpm for it under the files
tree. Very convenient seeing as how half the X rpms and apps want it to
install. Anywas, a quick visit to a redhat mirror should fix that.

WHAT I NEED: Anyways, if someone has already hand configured the X 3.3.3
under the pre-R5, send me an outline for getting it going. I did
softlink the DEV server already so I know my Xservers file is fine. Ive
got a G3 with standard ati rage. I have KDE and FVWM installed and the
Xclients files I have look fine.

NOTE: This was not all fun, I planned it for several days before I tried
it. During the process I had to wipe out my rpm db's. My fingers grew
tired from typing in --nodeps for the next few hours.

MYPLANS: Im gonna try to get gnome .99 and all of its required
libraries  to compile whether or not I get X up and running. I have a T3
and a G3 and I'm ready to fly.


(Geert-style) Cheers!

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
