Return-Path: <pochini@shiny.it>
Message-ID: <XFMail.20050929092052.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <1127865914.6102.0.camel@gaston>
Date: Thu, 29 Sep 2005 09:20:52 +0200 (CEST)
Sender: pochini@agnus.shiny.it
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 28-Sep-2005 Benjamin Herrenschmidt wrote:
> On Tue, 2005-09-27 at 18:30 +1000, Paul Mackerras wrote:
>> Christoph Hellwig writes:
>>
>> > What about just dropping POWER3/4 support in 32bit mode?
>>
>> Yes... I'm getting very close to deciding to do that.  In fact POWER3
>> isn't too bad, since it still has BATs, but POWER4/PPC970 would be
>> tricky.
>>
>> Does anyone on these lists have any major objections if we drop
>> support for 32-bit kernels on POWER3 and POWER4/PPC970?
>
> I've stopped supporting G5 on 32 bits kernel for some time now, I have
> absolutely no problem just dropping the POWER4 support in 32 bits kernel
> in the merged tree.

Out of curiosity, is there any advantage in using a 32 bits
kernel on ppc64 over a 64 bits kernel ?  Speed ?  Complexity ?
Compatibility ?  Memory ?



--
Giuliano.
