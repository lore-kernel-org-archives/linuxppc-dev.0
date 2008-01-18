Return-Path: <jsamch@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id EC59CDDDED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 13:49:16 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1192125pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 18:49:14 -0800 (PST)
Message-ID: <169c03cb0801171849i59d35893hda44a7f0c5417b58@mail.gmail.com>
Date: Thu, 17 Jan 2008 21:49:13 -0500
From: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Sender: jsamch@gmail.com
To: Jogi95@web.de
Subject: Re: ml310 kernel2.6 booting problems
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

> Date: Thu, 17 Jan 2008 21:19:04 +0100
> From: Joachim Meyer
> Hmmm... I'm not really ready to invest that much time into the PCI for ML=
-310.
> -------------------------------------------------------------------------=
-------
> http://ozlabs.org/pipermail/linuxppc-embedded/2007-December/029211.html
>
> How much work would it be (approximated), and do you think I can success =
(I'm a novice, like you know)?
> Would you help me (Tell me where to start & what to do)?

Hi Joachim,

I was also interested in getting the PCI to run on the ML-310.  I did
spend an evening trying to integrate a patch sent over by Stephen
Neuendorffer from Xilinx.  I managed to get everything to compile
(basically I fixed a few missing macros and had to search a bit to
ensure that the memory mapping was correctly ported).  Unfortunately,
when I tried the new kernel, I think that I must have messed something
up with the interrupt mappings (I am a newbie to PCI) and I had to
remove some interrupt mapping from Stephen's patch.

In any case, my ML-310 was booting the Linux kernel, but something was
not right and I did not get anymore printouts from the UART Lite.
Since I don't have the JTAG cable, I was stuck at this point with
little means to debug the system.  One day I'll spoil myself with one
of those platform JTAG USB cables...

I used Z-modem to transfer files to/from my workstation to my CF card
on the ML-310 and this was an acceptable compromise.

I'd still be interested in having the PCI bus working on the ML-310,
but now that I got my BEE2 booting Linux 2.6, its not such a big
priority for me.  Let me know if you have some success in that
direction.

Regards,

Jean-Samuel
--=20
Integrated Microsystems Laboratory
McGill University, Montr=E9al, QC, CANADA
Web Page: http://chaos.ece.mcgill.ca
