Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61E64DDFF8
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 17:41:50 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8169E3@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E8169E3@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EDDAA8FA-2056-4690-AE89-2C7E46BEFD14@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Fri, 12 Jan 2007 00:41:37 -0600
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2007, at 11:19 PM, Zhu Ebony-r57400 wrote:

> Hi Paul,
>
> This series of patch add support to fully comply with IEEE-754  
> standard
> for E500/E500v2 core when hardware floating point compiling is used.
>
> Ebony

Here are some general comments:
* We should be able to support math-emu (as it stands) and the fixup  
handling [you break math-emu]
* Copyrights / header comments should give credit to the orig math- 
emu code
* Why isn't there any handling of SPEFloatingPointRound exceptions?

- k
