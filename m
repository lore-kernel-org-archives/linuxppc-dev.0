Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Message-Id: <v04103d02b2f124333cb9@[10.1.1.5]>
Date: Wed, 17 Feb 1999 21:09:04 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Brett Dikeman <brett@pdikeman.ne.mediaone.net>
Subject: ixmicro ix3d card support
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having some problems with the latest kernels supporting my ix3d card.

According to ixMicro documentation and the big central chip's 
stamping "Twin Turbo 128-3D", my ixMicro Ultimate Rez card is really 
just a slightly faster tt128 card with some 3D stuff thrown in for 
yucks.

However, the card, if present in the system when the kernel loads, 
causes -severe- problems.  The last line displayed concerns the 
discovery+initialization of the floppy controller; then it spits out 
"machine check in kernel mode" and lots of stuff about the memory 
manager and "swapper".
(I have a photograph of the screen I took with a digital camera, so I 
can copy down the info or just post the JPG on my web server.)

>From all appearances, adding support for the ix3d card seems like it 
would require very little work since it is so similar to a twin turbo 
card, but I'm admittedly ignorant as to the finer details(or any 
details) of graphics card drivers :)

Once I complete an install of linux(had to blow it away months ago, 
never got around to replacing it) I can boot without the card, and 
help in testing anything in development for the card by swapping it 
in and out.

What would help considerably is a way to get the kernel to just 
ignore the ix3d card and use my 8500's builtin video instead.  Some 
sort of OF trick, maybe?

BTW, at the moment, I'm not subbed to the developer list.  I will 
certainly be doing so in the next few days, but in the meantime, 
please cc me on any messages regarding this.

Final note: I also have a PCI jackhammer SE card, identical to the 
one in many Workgroup servers and other apple systems.  Can't beat 
$150 for UW-SCSI3, and it would be -fantastic- to have my UW drive 
available.  I sort of assumed that with this card being in so many 
apple systems, that there would already be drivers for it.  Are there?

Thanks all!

Brett
----
Brett Dikeman
Network/System Administrator
Artel Software			617-451-9900x119
381 Congress Street			617-451-9916(fax)
Boston, MA 02210			brett@artelsoft.com
http://www.borisfx.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
