Message-Id: <37447E78.56C232F9@bcstec.ca.boeing.com>
Date: Thu, 20 May 1999 14:28:24 -0700
From: Ray Allis <ray@bcstec.ca.boeing.com>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Umax S900 CD Rom problems...
References: <BFC0587634C3D111AACB00805FA766FA0123B864@exchny12.ny.smb.com>
Content-Type: multipart/mixed;
 boundary="------------1CB4C8AF2D62486695CF283E"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------1CB4C8AF2D62486695CF283E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Velasquez, Carlos" wrote:

> Hello,
>
> Has anyone successfully installed  Linux on a Umax S900 Mac clone? If so,
> can you share your stories with me? I am having problems installing Linux on
> my Umax S900 (225 Mhz ppc with 162Meg ram, ixMicro Twin Turbo 8Meg video
> card.) Apparently, when I try to do a CD install, the installer doesn't
> recognize the CD Rom device. I believe I have a Matshita CD rom drive
> installed as an internal SCSI device (bus 0, Id 4).

I gave up. ;)  First attempt, the installer did not recognize the Twin Turbo.
Someone
on this list offered a fixed installer.  Then, the machine lost track of the
CD, so the
installer displayed o.k. but could not see anything to install. ;)  Then the
whole
SCSI went invisible - no CD, no floppy, no Zip.  Soooo, sent it to the shop,
where
they replaced the motherboard (where the SCSI chip was mounted).  Now the
installer
won't write (correctly) to the internal hard drives.  Seems the E100 chip sorta
refuses
to let the two 2-gig disks be anything but RAID, no matter how I initialize
them.
And then too, it's a twin processor SMP, and THAT won't run anything but the
Umax-supplied demos (MacOS 7.6) and then for a maximum of 30 minutes.

I'm parting it out ;).

Ray Allis


--------------1CB4C8AF2D62486695CF283E
Content-Type: text/x-vcard; charset=us-ascii;
 name="ray.vcf"
Content-Description: Card for Ray Allis
Content-Disposition: attachment;
 filename="ray.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard 
n:Allis;Ray
tel;work:+1 206 655 8870
x-mozilla-html:TRUE
org:The Boeing Company
adr:;;2-25.5 E5;Seattle;WA;;
version:2.1
email;internet:ray@bcstec.ca.boeing.com
title:Don' NEED no steenkin' ...
x-mozilla-cpt:;30304
fn:Ray Allis
end:vcard

--------------1CB4C8AF2D62486695CF283E--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
