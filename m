Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9446467A72
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 05:12:19 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Date: Wed, 19 Jan 2005 19:12:12 +0100
Message-ID: <JPEALJAFNGDDLOPNDIEEIEEEDAAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <90FFE0C0-6A3F-11D9-9943-003065F9B7DC@embeddededge.com>
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
> On Jan 18, 2005, at 7:30 PM, Joakim Tjernlund wrote:
> 
> > Something related I wonder about. Is it necessary to update the 
> > ACCESSED
> 
> Yes.  I used to take some shortcuts in the past that always marked pages
> accessed and dirty (if necessary) to eliminate code in the tlbmiss 
> handler.
> Paulus made me fix that, so page stealing and swapping would work
> more effectively.  However, I'm still considering making a configuration
> option because on embedded systems where the stealing and swapping
> don't occur you shouldn't have to pay the price of the management in
> the tlbmiss handler.

hmm, don't understand the page stealing part. Which configs doesn't
steal pages? All that doesn't swap?

 Jocke
