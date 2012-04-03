Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E38D7B6FD2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 11:26:53 +1000 (EST)
Message-ID: <1333416395.30734.70.camel@pasglop>
Subject: Re: [PATCH] powerpc/boot: Only build board support files when
 required.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 03 Apr 2012 11:26:35 +1000
In-Reply-To: <20120403010002.GE7481@truffala.fritz.box>
References: <20120403005558.GA9194@thor.bakeyournoodle.com>
 <20120403010002.GE7481@truffala.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Frank =?ISO-8859-1?Q?Svendsb=F8e?= <frank.svendsboe@gmail.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, Wolfgang Denk <wd@denx.de>,
 robert.karl.berger@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-03 at 11:00 +1000, David Gibson wrote:
> On Tue, Apr 03, 2012 at 10:55:59AM +1000, Tony Breeds wrote:
> > Currently we build all board files regardless of the final zImage
> > target.  This is sub-optimal (in terms on compilation) and leads to
> > problems in one platform needlessly causing failures for other
> > platforms.
> 
> Um.. I believe the one platform breaking another is actually working
> as intended.  I think Paulus did it this way to stop people breaking
> platforms other than the one they were working on without realising
> it.

But that doesn't make sense to enforce that accross CPU families since
they cannot be built together within a single kernel anyway...

Cheers,
Ben.
