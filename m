Message-Id: <v03110700b3d5daa1d5be@[209.183.131.45]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 10 Aug 1999 09:35:02 -0400
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Java for PPC dead?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>I've been a little busy lately, did I miss something? The Java for
>LinuxPPC project seems to have disappeared.
>
>http://business.tyler.wm.edu/mklinux/
>
>Did they move or end the project? My home machine is practically useless
>without Java. I haven't been successful in getting the source and seeing
>if it just compiles, and was hoping the team was working on it.
>
>Does anyone know the status, or who I might ask for a status?
>

No, JDK on PPC is  alive and well.  I have moved universities and my
website had to come down.  I have a new machine and a new website coming
but given the pace of the move and a death in my family, things have had to
take a back seat.

Here is a status report:

Currently:

For R4, MkLinux DR3 systems (glibc 1.99 based):
   - all further development work has stopped for glibc 1.99 systems
     (so consider upgrading to glibc 2.1!)
   - currently jdk 1.2, jdk 1.1.7 and metrowerks JIT for jdk 1.1.X
     exist and are available from ftp.mklinux.apple.com in the contributed
     jdk subdirectory (the last known repositiory)

For R5, YDL, MkLinux R1 systems (glibc 2.1 based)
   - all new dvelopment is only going on for glibc 2.1
   - currently jdk1.2 is available from the YDL ftp site (and its mirrors)
     and it is on the LinuxPPC 1999 source cd (as a binary to install)


JDK 1.1.8 for glibc 2.1 systems is currently in testing and jdk 1.2.1 is
being built as we speak.  The Metrowerks JIT compiler for JDK 1.1.X has
also been brought to glibc 2.1 systems.

There is a known problem with jdk 1.2 swing and XFB68_Dev X server because
that server incorrectly sets depth to bits per pixel.  The only known
workaround is to use the Xpmac server which sets things correctly and works
fine, and which will work with usb keyboards but won't work with usb mice.
Once I figure another workaround (fixing the FB68_Dev or adding usb mice
support to Xpmac), I will post the new versions.

All of this will hopefully be available from my new website soon.

If you have specific questions, please contact me throught the lists or
by sending mail to khendricks@ivey.uwo.ca

I still need *help* with:

  - fixing the XFB68_Dev Xserver to report the right depth for 555 color mask
  - fixing Xpmac server to see and use usb mice
  - help testing the jdk before a general release
  - help porting the Metrowerks JIT from jdk 1.1.X to jdk 1.2.X

If there are any volunteers (especially for fixing the Xservers) I would
really appreciate hearing from you!!!!!!

I hope this answers your questions.

Thanks,

Kevin

Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business
University of Western Ontario
London, Ontario
khendricks@ivey.uwo.ca







[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
