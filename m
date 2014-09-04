Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59B9F1A0061
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 18:08:10 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9864C140080
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 18:08:09 +1000 (EST)
Message-ID: <1409818074.4246.53.camel@pasglop>
Subject: Re: TTM placement & caching issue/questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 04 Sep 2014 18:07:54 +1000
In-Reply-To: <54081BC5.8000703@daenzer.net>
References: <1409789547.30640.136.camel@pasglop>
 <20140904015548.GB4835@gmail.com> <20140904020742.GC4835@gmail.com>
 <1409797523.25089.8.camel@pasglop> <20140904023117.GD4835@gmail.com>
 <20140904023656.GF4835@gmail.com> <54081282.3040005@daenzer.net>
 <1409817275.4246.40.camel@pasglop> <54081BC5.8000703@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@ozlabs.org,
 Michel =?ISO-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-04 at 16:59 +0900, Michel Dänzer wrote:
> 
> Define 'not reliably'. I have uptimes of weeks, and I'm pretty sure I'm 
> not alone, at least with AGP 1x it seems to work quite well for most 
> people. So I don't see the justification for intentionally breaking it 
> completely for all of us.

Oh I wasn't arguing for breaking it, just jesting. We need to keep it
working. It's amazing how well broken stuff actually work though :-)

I mean, it's architecturally broken and if we get a collision between
the cache and the NCU, the chip will crash. We just get lucky I suppose.

Anyway, I'll try a different approach tomorrow see how it goes.

Cheers,
Ben.
