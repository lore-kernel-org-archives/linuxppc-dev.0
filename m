Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECE0167A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 05:06:50 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Date: Wed, 19 Jan 2005 19:06:41 +0100
Message-ID: <JPEALJAFNGDDLOPNDIEEAEEEDAAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <28C8C10C-6A3F-11D9-9943-003065F9B7DC@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] Handle I-TLB Error and Miss separately on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> On Jan 18, 2005, at 5:02 PM, Joakim Tjernlund wrote:
> 
> > Then all that is missing is my dcbX patch and support for 16K pages :)
> 
> We'll get to that.  I'd prefer to support 4K and 8M pages, though.  I had

8MB pages for user space? Isn't that a bit big?

> started on doing that, some code remnants are still there, but I never
> got it to work without adding too much code to the I-tlbmiss hander.
> I want an tlbmiss handler like the example in the manual, about 10
> lines of straight code.  I don't like to be mucking around with PTE 
> entries
> a higher level function could/should have set for us in a less critical 
> path.

yes, that would be nice :)

> 
> 	-- Dan
> 
