Message-ID: <3CFF7496.6050904@thales-bm.com>
Date: Thu, 06 Jun 2002 16:41:26 +0200
From: Julien Eyries <julien.eyries@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [Fwd: Re: kernel command line for CRAMFS root filesystem]
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-------- Original Message --------
Subject: Re: kernel command line for CRAMFS root filesystem
Date: Thu, 06 Jun 2002 16:40:33 +0200
From: Julien Eyries <julien.eyries@thales-bm.com>
To: acurtis@onz.com
References: <NCBBIINEHIPFGJPLBEIFKEEIDIAA.acurtis@onz.com>


i have never mounted it before .

i am currently booting with initrd (good :-)) from my flash and it works
fine( the commandline was : root=/dev/rd/0 );
but now i want to replace that with a cramfs (better :-)) .

anyway, i know i can acess to the range (start 0xfe100000 - length
2MBytes) via my partition /dev/mtdblock/2 but if i try something like :
   root=/dev/mtdblock/2 then JFFS2 try to mount it as root filesystem and
fails !!!!!!

maybe i should add something to the commandline, in order to tell the
kernel that /dev/mtdblock/2 contains a CRAMFS partition ??






Allen Curtis wrote:

 >>i have a cramfs image in flash, at address 0xfe100000 (length of image
 >>is 2MBytes).
 >>what is the kernel command line "root=..." to use this image as root
 >>filesystem ?
 >>
 >
 > What is the device name when you mount it from a bootp session? The
name is
 > probably the same...
 >
 >


--
Julien Eyries
R&D engineer
Thales Broadcast & Multimedia (ex-thomcast)
email: julien.eyries@thales-bm.com
fax: 33(0) 1 34 90 31 10
tel: 33(0) 1 34 90 31 01





--
Julien Eyries
R&D engineer
Thales Broadcast & Multimedia (ex-thomcast)
email: julien.eyries@thales-bm.com
fax: 33(0) 1 34 90 31 10
tel: 33(0) 1 34 90 31 01


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
