Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C973BDDE35
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:05:27 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816A6B@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A6B@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00d809d44c8e8286fd4bf9de16ee6b10@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Fri, 12 Jan 2007 13:06:04 +0100
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

> I wrote some cases for testing. For SPFP and DPFP exception testing,
> the test cases included plus, minus, multiply, divide, comparisons, 
> conversions,
> DBZ... for Nan/Denorm/Inf numbers. I also tested the cases that
> the operation result would generate Nan/Denorm/Inf/overflow/underflow
> numbers. For Vector SPFP exception testing, I wrote inline asm based 
> testing
> program to test the instructions directly.

Any chance you could submit that testing code too?  Would
be useful for others :-)


Segher
