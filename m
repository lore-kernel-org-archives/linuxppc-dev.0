Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 6FC14DE0FF
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 04:54:57 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2456240ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 09:54:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b5e2fc790901270952p42fefb5fx63b77449528a448c@mail.gmail.com>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205540.31232.77034.stgit@localhost.localdomain>
	<b5e2fc790901270952p42fefb5fx63b77449528a448c@mail.gmail.com>
Date: Tue, 27 Jan 2009 10:54:55 -0700
Message-ID: <fa686aa40901270954l44d5d8feh464ffc7389abc56f@mail.gmail.com>
Subject: Re: [PATCH 7/8] powerpc/5200: Refactor mpc5200 interrupt controller
	driver
From: Grant Likely <grant.likely@secretlab.ca>
To: Matt Sealey <matt@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 27, 2009 at 10:52 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> On Wed, Jan 21, 2009 at 2:55 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> Rework the mpc5200-pic driver to simplify it and fix up the setting
>> of desc->status when set_type is called for internal IRQs (so they
>> are reported as level, not edge).  The simplification is due to
>> splitting off the handling of external IRQs into a separate block
>> so they don't need to be handled as exceptions in the normal
>> CRIT, MAIN and PERP paths.
>
> Can I assume this has absolutely no functional impact compared to the
> old one? It doesn't change any behaviour, just implements exactly the
> same in a much nicer way?

Plus small bug fixes.  It should have no functional impact on stuff
that already works.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
