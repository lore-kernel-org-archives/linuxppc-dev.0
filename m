Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E75526884F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 19:08:56 +1100 (EST)
To: gil-ad@myrealbox.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 29 Nov 2005 01:47:05 +0200."
	<200511290147.05220.gil-ad@myrealbox.com>
Date: Tue, 29 Nov 2005 09:08:54 +0100
Sender: wd@denx.de
Message-Id: <20051129080854.06789353F54@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Problem running kernel 2.6.14 (DENX) on MPC866 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200511290147.05220.gil-ad@myrealbox.com> you wrote:
> 
> I load linux from u-boot, and manage to go all the way until the call to cpu_idle() from rest_init().
> The system claims mounts a root file system over NFS. Sniffer logs and host logs support this claim.
> If I do a while ( 1 ) printk( whatever ), just before cpu_idle(), the system continues to run.
> If I let it call cpu_idle(), the system hangs.

For 8xx you could / should use the kernel.org tree. We don't use  2.6
on 8xx yet.

> U-Boot 1.1.3 (Nov 22 2005 - 00:26:43)
> 
> CPU:   unknown MPC86x (0x08010004) at 133 MHz: 16 kB I-Cache 8 kB D-Cache FEC present
>          *** Warning: CPU Core has Silicon Bugs -- Check the Errata ***

You should fix this.

> Monitor Command Prompt:>setenv gatewayip 10.0.0.138;setenv ethaddr 00:01:02:03:04:05; setenv console ttyCPM0,38400n8; setenv

You use an illegal MAC address; please read the FAQ, especially
http://www.denx.de/wiki/view/DULG/EthernetDoesNotWork  and
http://www.denx.de/wiki/view/DULG/WhereCanIGetAValidMACAddress


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
How many seconds are there in a year? If I tell you there are 3.155 x
10^7, you won't even try to remember it. On the other hand, who could
forget that, to within half a percent, pi seconds is  a  nanocentury.
                                               -- Tom Duff, Bell Labs
