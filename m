Return-Path: <dgibson@ozlabs.org>
Date: Fri, 13 Jun 2008 13:41:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: dtc: Add support for binary includes.
Message-ID: <20080613034103.GA29451@yookeroo.seuss>
References: <483C4C04.9020408@freescale.com>
	<20080528235859.GA10260@yookeroo.seuss>
	<20080529000227.GB10260@yookeroo.seuss>
	<48404D83.4070108@freescale.com>
	<20080604041304.GD29085@yookeroo.seuss>
	<4846A60F.9020909@freescale.com>
	<20080611015839.GB22012@yookeroo.seuss>
	<20080612164322.GA2972@loki.buserror.net>
	<20080613000125.GA10981@yookeroo.seuss>
	<4851C378.9000506@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4851C378.9000506@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 07:46:48PM -0500, Jon Loeliger wrote:
> David Gibson wrote:
>
>>> It'd be nice if we could keep the filename around for reporting here...
>>
>> It would.  Well, I've been intending to clean up the input file
>> handling in several ways already, I'll see if that can be worked in.
>>
>
>
> With Scott's ACK on this, I intend commit David's patch.
> So if you adjust the input file reporting here, please
> do it as an "additional patch."

Oh, yes.  That was always my intention.

> And for the record, I will also make an official tagged
> release just after any such cleanup patch appears, or
> in the next couple days, whichever comes first.

Ok.  I doubt I'll have that cleanup done in the next couple of days.
It can wait until after the tag.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
