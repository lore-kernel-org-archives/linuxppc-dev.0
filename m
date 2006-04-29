Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17490.51212.357234.664398@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 11:57:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC , PATCH] support for the ibm,pa_features cpu property
In-Reply-To: <20060428192149.GJ5518@pb15.lixom.net>
References: <1146249684.27214.18.camel@localhost.localdomain>
	<20060428192149.GJ5518@pb15.lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Do you know why they went for this brand new extra architected bitfield
> instead of continuing down the way that processor features always have
> been documented before, by adding a property to the cpu device node?

They wanted to cover basically everything that we have CPU feature
bits for, plus some other things.  That would have been a lot of new
properties, so they went for one that had a bitmap in it, and made it
extensible in two different directions for good measure while they
were at it. :)

> (Now, the naming convention of calling it a "pa feature" is unfortunate,
> but nothing I can really complain about since our stuff is not yet in
> tree.)

The "pa" is just "processor architecture", nothing to do with your
employer. :)

Paul.
