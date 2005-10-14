Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id E408E68584
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Oct 2005 18:45:30 +1000 (EST)
To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "14 Oct 2005 08:22:20 -0000."
	<20051014082220.32133.qmail@webmail10.rediffmail.com>
Date: Fri, 14 Oct 2005 10:45:12 +0200
Sender: wd@denx.de
Message-Id: <20051014084512.7E8AA352B7B@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ramdisk image, unable to mount fs 01:00 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051014082220.32133.qmail@webmail10.rediffmail.com> you wrote:
> 
> i got linux-2.4.25 from denx devel cvs kernel , when i try
> to mount thr root fs , kernel panics giving the down message , 

There is no "down message" in your mail.

> i have used tis ramdisk image for 2.4.18 stock kernel , 
> cant i use the same ramdisk as i have compiled kernel using the same compiler , ?

You should be able to use the same ramdisk image.

> ## Booting image at 00500000 ...
>    Image Name:   Linux-2.4.25
>    Image Type:   PowerPC Linux Kern el Image (gzip compressed)                  
>    Data Size:    473290 Bytes = 462.2 kB
                   ^^^^^^^^^^^^^^^^^^^^^^^

This image is way too small for a working 2.4.25 system. I guess  you
seriously  misconfigured  the Linux kernel. Probably support for some
needed features (like ext2  file  system,  ramdisk,  initial  ramdisk
etc.) might be missing.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What's the sound a name makes when it's dropped?
