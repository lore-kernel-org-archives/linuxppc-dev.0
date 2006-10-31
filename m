Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <45468775.8040108@246tNt.com>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
	<45468775.8040108@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <96623161-B847-4F61-94AB-D1F1B1767708@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support
	for	ARCH=powerpc
Date: Mon, 30 Oct 2006 19:11:10 -0600
To: Sylvain Munaut <tnt@246tNt.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> * lets drop all the other struct defn in mpc52xx.h.  This is a hold
>> over from arch/ppc and we really should only put defn that we
>> actually need closer to the code that uses them (ie, drivers, etc.)
>>
> Most of the struct that were in mpc52xx.h are the ones used in more  
> than
> one driver.
> (or don't really belong to a driver)
> That's why they've been left there and not in the driver header, so I
> would leave those
> there.
>
> (e.g. the IDE struct is not there, neither is the FEC. But sdma is  
> used
> at several place
> for example, so is rtc, xlb and cdm, ...)

I can see that some of these might be used, like SDMA, XLB, and CDM.   
However, others like RTC should really be done via a single driver.   
Additionally, I'd have to see code use GPIO, SDRAM, GPT, etc before I  
think we should have them defined here.  I'd rather we add these  
items as they are used rather than having them here wholesale.

- kumar
