Return-Path: <xyzzy@speakeasy.org>
Received: from mail8.sea5.speakeasy.net (mail8.sea5.speakeasy.net
	[69.17.117.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0006DDDF25
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 20:25:19 +1100 (EST)
Date: Tue, 1 Apr 2008 02:18:44 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2] powerpc: Describe memory-mapped RAM&ROM chips OF
	bindings
In-Reply-To: <200804011047.42971.laurentp@cse-semaphore.com>
Message-ID: <Pine.LNX.4.64.0804010217470.3571@t2.domain.actdsltmp>
References: <200803311839.10519.laurentp@cse-semaphore.com>
	<47F11A19.4050305@ru.mvista.com>
	<200804011047.42971.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, MTD mailing list <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Apr 2008, Laurent Pinchart wrote:
> On Monday 31 March 2008 19:06, Sergei Shtylyov wrote:
>>>        p) Freescale Synchronous Serial Interface
>>> -	  q) USB EHCI controllers
>>> +      q) USB EHCI controllers
>>> +      r) Memory-mapped RAM & ROM
>>
>>     Memory-mapped RA/RO Memory again? Should better drop this. :-)
>
> You're quite picky, aren't you ? :-)
>
> I suppose "Memory-mapped RA & RO" won't be accepted, so what about "Auxiliary
> RAM & ROM" ?

Direct-mapped?
