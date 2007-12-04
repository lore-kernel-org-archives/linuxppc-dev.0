Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 9B4E9DDE22
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 13:10:29 +1100 (EST)
Date: Mon, 3 Dec 2007 19:12:12 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] PowerPC 74xx: Katana Qp base support
Message-ID: <20071204021212.GC18903@mag.az.mvista.com>
References: <20071129154200.GE13751@ru.mvista.com>
	<1196715299.13230.230.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196715299.13230.230.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 07:54:59AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2007-11-29 at 18:42 +0300, Andrei Dolnikov wrote:
> > +config PPC_KATANAQP
> > +       bool "Emerson-Katana Qp"
> > +       depends on EMBEDDED6xx
> > +       select MV64X60
> > +       select NOT_COHERENT_CACHE
>                  ^^^^^^^^^^^^^^^^^^
> 
> Just one word: ARGHHHHHHHH !
> 
> Oh and another one: WHY ?

I responded to your other email regarding this.

Mark
