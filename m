Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CD84DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 09:13:37 +1100 (EST)
Message-Id: <4F3495E5-5A2A-485F-86FC-8EE2DF79F12F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kyle McMartin <kyle@mcmartin.ca>
In-Reply-To: <20090402220947.GG14159@bombadil.infradead.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC][PATCH] powerpc: Emulate enough of SPE instructions to make
	gcc happy
Date: Thu, 2 Apr 2009 17:13:24 -0500
References: <1238709887-26237-1-git-send-email-galak@kernel.crashing.org>
	<20090402220947.GG14159@bombadil.infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 2, 2009, at 5:09 PM, Kyle McMartin wrote:

> On Thu, Apr 02, 2009 at 05:04:47PM -0500, Kumar Gala wrote:
>> +config SPE_EMULATION
>> +	bool "SPE Emulation Support"
>> +	depends on (CLASSIC32 || POWER4) && !ALTIVEC && !SPE
>> +	---help---
>> +	  This option enables kernel support for the Altivec extensions  
>> to the
>> +
>
> Looks like you kind of trailed off here... :)

Yeah, the patch is still a bit of a hack.. I'm just trying to gage  
interest.  If there is any than I'll spend some more effort to clean  
it up.

:)

- k
