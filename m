Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3819DDF26
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:43:51 +1000 (EST)
Message-ID: <464DD5E3.1060301@freescale.com>
Date: Fri, 18 May 2007 11:35:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
	<464C871C.4090300@freescale.com>
	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
	<20070518171555.543f9bdc@hyperion.delvare>
	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>
In-Reply-To: <D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I guess my gripe is about proposing a solution and not willing to  
> extend it in light of people providing issues with it. 

I'm perfectly willing to extend it if you let me know what you think is 
needed, rather than just saying "switches and muxes".  What 
*specifically* would they need beyond what I proposed?

> Last time I  
> check we don't put things into the kernel w/o any review and if  people 
> have issues that are reasonable they get hashed out.  It seems  that the 
> onus is on the initial submitter to either show that what  they are 
> providing is sufficient and w/o issue or incorporate the  feedback.

Give me something I can incorporate, then.  My gripe is when the 
feedback is "don't bother" based on unspecified problems with a 
configuration more complex than what it was intended to address (but 
still, AFAICT, not outside its ability to address).

> More specifically, we have a way to specify what devices are connect  on 
> I2C today.  I'm not convinced there is any value in creating yet  
> another mechanism, especially in an interface that in theory should  be 
> linux agnostic.

We had a way to specify platform devices before, too.  If the device 
tree isn't worthwhile for i2c devices, why is it worthwhile for soc 
devices?  It seems to me that non-probable chips like i2c devices are 
precisely the kind of thing that the device tree is useful for.

-Scott
