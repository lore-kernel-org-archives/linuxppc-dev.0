Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 14B30DDFB1
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 02:24:39 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so760445anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Feb 2008 07:24:38 -0800 (PST)
Message-ID: <fa686aa40802050724o692ef9e7yf51945225f56da5b@mail.gmail.com>
Date: Tue, 5 Feb 2008 08:24:38 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
In-Reply-To: <20080205091548.724c4e20@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200802031729.12069.bernhard@intevation.de>
	<20080204095121.GA18167@powerlinux.fr>
	<20080205070833.3a5b7c11@zod.rchland.ibm.com>
	<20080205143926.GA9709@powerlinux.fr>
	<20080205091548.724c4e20@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Bernhard Reiter <bernhard@intevation.de>,
	debian-powerpc@lists.debian.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/5/08, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > I mean, if you have not included 4xx support in the kernel, as is the
> > case here, it does not make sense to add the 4xx bootwrapper code, no ?
>
> It does, in a manner.  There are both generic and platform specific
> pieces to the bootwrapper.  Having everything always built helps keep
> the generic bits from breaking, which is important as they're often
> tightly coupled.  That's at least the reason I can think of.
>
> The powerpc maintainers have been over this quite a bit and I don't see
> it changing anytime soon.

That would mean we're dropping support for compilers which can't build
405/440 specific wrapper bits (or other core specific quirks that need
to go in the wrapper)  That doesn't sound appropriate to me.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
