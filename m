Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 534A0DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:47:57 +1100 (EST)
Message-ID: <45D5E022.4020306@am.sony.com>
Date: Fri, 16 Feb 2007 08:47:30 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [0/3] RFC: Cleanups and improvements to the zImage wrapper
References: <20070216062458.GA23008@localhost.localdomain>
In-Reply-To: <20070216062458.GA23008@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> Here is a set of three patches that make some substantial changes to
> the zImage wrapper's flow of control.  These changes make things more
> flexible, in order to more easily handle a wider variety of
> platforms.  They also make some things clearer than previously.
> 
> I think these are fairly close to ready to merge, but they need more
> testing on various platforms.  In particular, I'm not terribly whether
> my changes will work correctly on old powermac platforms booting from
> COFF.

Could I request some in-line documentation be added as we have in other
parts of the kernel to describe function arguments, etc.?

-Geoff
