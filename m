Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B4CADDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:04:07 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816A58@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A58@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <044bc5d89a68ac70c37f1796fb4547c1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Fri, 12 Jan 2007 13:04:43 +0100
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> * Why isn't there any handling of SPEFloatingPointRound exceptions?
>
> I think the SPEFloatingPointRound exception is not necessary to handle 
> if we
> handle floating point exception this way.

Some more explanation than "I don't think so" would
be nice ;-)


Segher
