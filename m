Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] return to OF via trap, not exit
From: Michael Ellerman <michael@ellerman.id.au>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060323210357.GC24667@suse.de>
References: <20060304191026.GA9815@suse.de>
	<200603061212.12815.michael@ellerman.id.au>
	<20060306073834.GA24869@suse.de>
	<590CA2B3-AACE-4B69-930D-9A66A42FFC83@kernel.crashing.org>
	<20060306074339.GC24869@suse.de>
	<1912CD56-027C-491D-B2A2-EA44AB4DDD14@kernel.crashing.org>
	<20060306074953.GE24869@suse.de>
	<EA07A673-A993-490A-ADEC-29CFDF1DDAC1@kernel.crashing.org>
	<20060323210357.GC24667@suse.de>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 10:11:28 +1100
Message-Id: <1143155488.23790.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-03-23 at 22:03 +0100, Olaf Hering wrote:
>  On Mon, Mar 06, Segher Boessenkool wrote:
> 
> > That's better than always calling trap, sure.  Is there any reason
> > you can't just do it on Macs though?  Because the problem you're trying
> > to work around only happens there.
> 
> Maybe something like this? Only compile tested
> 
> 
> Do not call prom exit prom_panic. It clears the screen and the exit message is lost.
> On some (or all?) pmacs it causes another crash when OF tries to print the
> date and time in its banner.
> 
> Set of_platform earlier to catch more prom_panic() calls.

Looks reasonable, assuming it works :)

cheers

-- 
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person
