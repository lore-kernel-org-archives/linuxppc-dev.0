Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 59B0C67C26
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 10:43:54 +1100 (EST)
To: tran vanle <vantranbk@yahoo.com.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Ramdisk of ELDK 3.1.1 not run 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 07 Nov 2006 01:26:04 +1100."
	<20061106142604.14632.qmail@web33012.mail.mud.yahoo.com>
Date: Tue, 07 Nov 2006 00:43:51 +0100
Sender: wd@denx.de
Message-Id: <20061106234351.EB8DF353A5F@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20061106142604.14632.qmail@web33012.mail.mud.yahoo.com> you wrote:
>
> I had used kernel of ELDK 3.1.1 and Ramdisk of ELDK 4.0 on board MPC8xxL .It run ok but I see it will meet trouble :D

Yes, this is to be expected. The ELDK 4.0 ramdisk built  with  a  2.6
kernel in mind.

> When I use kernel and Ramdisk of ELDK 3.1.1 for MPC8xxL (I only rebuild Kernel use oldconfig and use uRamdisk in source (not rebuild )) but I receive error
...
> Kernel command line: 

You don't pass any boot arguments here.

> What I miss?May i correct it 

You obviously missed to read the documentation. Please see
http://www.denx.de/wiki/view/DULG/LinuxKernelArgs

> I also build kernel Linux 2.6.11.7 use tosati patch and config ,but when I want this kernel support virtual terminal it hang.May I correct it?

You probably missed to define correct boot arguments, especially a
correct console device; note that 2.6 uses ttyCPM0 instead of ttyS0,
etc.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I don't know if it's what you want, but it's what you get.  :-)
                      - Larry Wall in <10502@jpl-devvax.JPL.NASA.GOV>
