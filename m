Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D4F3DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Nov 2007 00:56:06 +1100 (EST)
Message-ID: <472B2C31.3090806@freescale.com>
Date: Fri, 02 Nov 2007 08:54:57 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: =?windows-1252?Q?=3F=3F?= <guojin02@tsinghua.org.cn>
Subject: Re: The question about the fail at the begin of linux on MPC8360E.
References: <393972917.10298@tsinghua.org.cn>
	<598D5675D34BE349929AF5EDE9B03E270174CCE3@az33exm24.fsl.freescale.net>
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270174CCE3@az33exm24.fsl.freescale.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

Medve Emilian-EMMEDVE1 wrote:
> Hi there,
> 
> 
> You need a device tree. The defaut one is arch/powerpc/boot/dts/mpc836x_mds.dts. You need the DTC (Device Tree Compiler) from here http://jdl.com/git_repos/?p=dtc.git;a=summary. This should be enough to give you some reading pointers.

And if your U-Boot doesn't support device trees, you'll need to enable cuImage 
support in the kernel as well.

-- 
Timur Tabi
Linux kernel developer at Freescale
