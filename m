To: Abraham van der Merwe <abz@frogfoot.net>
Cc: Linux PowerPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: how to hardcode ramdisk parameters in kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Jan 2003 13:27:33 +0200."
             <20030117112733.GA16093@oasis.frogfoot.net>
Date: Fri, 17 Jan 2003 18:43:23 +0100
Message-Id: <20030117174328.0C652C608E@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20030117112733.GA16093@oasis.frogfoot.net> you wrote:
>
> cat zImage.bin ramdisk.gz > boot.bin
>
> and then I want to write initrd_start (size of zImage.bin) and initrd_end
> (initrd_start+size of ramdisk.gz) somewhere in the boot.bin binary and the
> kernel should know where to find the ramdisk in memory at boot time.

make zImage.initrd


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A man is not complete until he is married -- then he is finished.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
