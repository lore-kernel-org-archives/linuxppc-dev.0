Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DB457DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 03:54:29 +1100 (EST)
Date: Fri, 24 Oct 2008 20:54:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3] powerpc: Specify GPIO number base for controller in DT
Message-ID: <20081024165428.GC14350@oksana.dev.rtsoft.ru>
References: <1224764850.4082.54.camel@galileo.recco.de>
	<D6AED5C1-6936-48BB-8D0F-98471C6841B0@kernel.crashing.org>
	<1224773378.4082.64.camel@galileo.recco.de>
	<200810232013.00539.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200810232013.00539.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Ocker <weo@reccoware.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 08:13:00PM +0200, Stefan Roese wrote:
> On Thursday 23 October 2008, Wolfgang Ocker wrote:
> > The GPIOLIB allows the specification of a base gpio number for a
> > controller. That is not possible using OF. Instead, free gpio numbers
> > are assigned.
> >
> > In order to allow static, predefined gpio numbers, a base property in
> > the gpio controller node specifies the first gpio number.
> >
> > v2, v3: added/improved description of base property in doc
> 
> These version descriptions are better placed below the "---" line. And you 
> should remove the "Re: " from the subject line. Other than this:
> 
> Acked-by: Stefan Roese <sr@denx.de>

Please-defer-this-patch-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Wolfgang, Stefan, see this comment:

http://ozlabs.org/pipermail/linuxppc-dev/2008-October/064505.html

..just tell me what are you trying to solve.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
