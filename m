Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2AF8F679EB
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 13:48:00 +1000 (EST)
Date: Fri, 28 Apr 2006 22:46:42 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC , PATCH] support for the ibm,pa_features cpu property
Message-ID: <20060429034642.GK5518@pb15.lixom.net>
References: <1146249684.27214.18.camel@localhost.localdomain>
	<20060428192149.GJ5518@pb15.lixom.net>
	<17490.51212.357234.664398@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17490.51212.357234.664398@cargo.ozlabs.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 29, 2006 at 11:57:32AM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Do you know why they went for this brand new extra architected bitfield
> > instead of continuing down the way that processor features always have
> > been documented before, by adding a property to the cpu device node?
> 
> They wanted to cover basically everything that we have CPU feature
> bits for, plus some other things.  That would have been a lot of new
> properties, so they went for one that had a bitmap in it, and made it
> extensible in two different directions for good measure while they
> were at it. :)

Sure, it might be a few, but we already have a handful. And having a
bitfield only gives you a chance to say here or not, no version numbers,
capacities, etc.

Anyway, I can't really debate it since I haven't seen the spec, just one
implementation.

> > (Now, the naming convention of calling it a "pa feature" is unfortunate,
> > but nothing I can really complain about since our stuff is not yet in
> > tree.)
> 
> The "pa" is just "processor architecture", nothing to do with your
> employer. :)

Yes, I know. Just saying. :)


-Olof
