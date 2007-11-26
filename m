Return-Path: <timur@freescale.com>
Message-ID: <474AF711.9010602@freescale.com>
Date: Mon, 26 Nov 2007 10:40:49 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Revisited, audio codec device tree entries.
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>	
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>	
	<9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>	
	<fa686aa40711190831s2e59ab05h63d10ec8a24eaad5@mail.gmail.com>	
	<9e4733910711190851g3e1f2ef9k5f87c7c2dae929ef@mail.gmail.com>	
	<fa686aa40711190933r3cbeb51bw7b9073a40f8396ed@mail.gmail.com>	
	<9e4733910711191120l45d9257bwf4ccf8c7365393d0@mail.gmail.com>	
	<fa686aa40711191128i59245403g3e15e3b6c545b6ee@mail.gmail.com>	
	<20071120005941.GC3126@localhost.localdomain>	
	<474AEB6A.40408@freescale.com>
	<9e4733910711260838s26e5b155n8d1cb2c246248394@mail.gmail.com>
In-Reply-To: <9e4733910711260838s26e5b155n8d1cb2c246248394@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> I'm fixing up the asoc v2 code to use MODULE_DEVICE_TABLE() and the
> real kernel aliasing/insmod system. Half of why we are having trouble
> is because asoc isn't using this mechanism. I've posted patches fixing
> i2c to use the same mechanism.  I don't have the asoc ones ready yet.

I look forward to porting my driver to ASoC V2 once the dust settles. :-)  In 
the meantime, I'll post the V1 version this week or next.

-- 
Timur Tabi
Linux kernel developer at Freescale
