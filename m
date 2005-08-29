Return-Path: <susheel.nuguru@mitron.fi>
Received: from mitron.mitron.fi (mail.mitron.fi [82.116.252.3])
	by ozlabs.org (Postfix) with ESMTP id 6972568146
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 17:23:38 +1000 (EST)
From: Nuguru Susheel <susheel.nuguru@mitron.fi>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 29 Aug 2005 10:26:15 +0000
Message-Id: <1125311175.3232.12.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: problem mounting ROOT-NFS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Yan,
   Yes its true, but why. I checked the permissions for the nfs-root directory in /etc/exports and it is set to no_root_squash which should not be a problem.
I could access the nfs server when I boot from ramdisk or NOR flash ...

Why is that it couldnt get mount nfs-root while i boot from sram ???? I assume boot peramets should not be doing this?? 

any hints


>	Your nfs server did not startup, or with a wrong port.

> Best regards,
> Yan

======= At 2005-08-26 18:37:28 you wrote =======

>Hi,
>
>  I lately upgraded to Bestcomm API v2.2 from v2.1 , but root-nfs doesnt
>mount while booting from ram, but when booting from FLASH (Compact Flash
>and also NOR) it does well. This problem could be seen when I try to
>boot on MPC5200 RevA. 
>
> Then I switched to MPC5200 RevB to see it is the same here, but with
>same u.boot.bin and kernel image everything boot well on Rev B. I have
>compared the Environment perameters passed from u-boot to the kernel and
>everything seems to be the same. I also looked into the Errata to check
>if anything else regarding bestcomm or fec has changed, but couldnt
>figure out anything.
>
>console messages while booting on MPC5200 RevA from ram goes this
>way ...
