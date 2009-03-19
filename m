Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CA47DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 12:34:33 +1100 (EST)
Date: Thu, 19 Mar 2009 12:20:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090319012028.GA22262@yookeroo.seuss>
References: <20090317185902.GB4055@oksana.dev.rtsoft.ru>
	<D688018D-6CE0-4627-B813-FC552B1A6E83@kernel.crashing.org>
	<20090318152800.GA29557@oksana.dev.rtsoft.ru>
	<20090318154307.GB3182@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090318154307.GB3182@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 10:43:07AM -0500, Scott Wood wrote:
> On Wed, Mar 18, 2009 at 06:28:00PM +0300, Anton Vorontsov wrote:
> > It would be great to have #include <gianfar_enet.dts> facility in .dts
> > files. ;-) I heard some rumors about this, what was the consequence?..
> 
> You can already do a raw include, but in most cases it needs parameterized
> templates/macros to make it useful.  There were some patches floating around
> for that, but there was some disagreement about syntax and the discussion
> seems to have died out.

Yeah - basically Jon got busy with other things, so we no longer had
critical mass to keep things moving.  I have an idea for a partway
step that will be enough for at least some applications without making
life awkward for a more complete approach later.  Basically the idea
is just to have "weak" property assignments - you can have an include
file which has a bunch of these, but they can be silently overriden by
normal property assignments afterwards.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
