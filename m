Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 632C2DDF0C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 03:07:29 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816BEC@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816BEC@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <78292fa76d5867b52f6c56d21a0a090c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with
	IEEE-754standard
Date: Mon, 15 Jan 2007 17:08:05 +0100
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Do you mean we can make a switch in order to let user choose
> whether to enable exception handling or just use default value?

Yes exactly.  I'm not sure what kind of interface you should
use for this though, maybe a sysctl?  Someone else can tell
you I hope :-)


Segher
