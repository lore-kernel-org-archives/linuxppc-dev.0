Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Jan 2011 10:35:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
Subject: Re: [PATCH] of/device: Don't register disabled devices
Message-ID: <20110105233535.GB8846@yookeroo>
References: <20110103230122.25772.72990.stgit@localhost6.localdomain6>
	<DD7A9A95166BF4418C4C1EB2033B6EE2038FA8E5@na3-mail.mgc.mentorg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DD7A9A95166BF4418C4C1EB2033B6EE2038FA8E5@na3-mail.mgc.mentorg.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Saxena,
	Deepak" <deepak_saxena@mentor.com>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2011 at 02:53:27PM -0800, Blanchard, Hollis wrote:
> On 01/03/2011 03:01 PM, Grant Likely wrote:
> > Device nodes with the property status="disabled" are not usable and so
> > don't register them when parsing the device tree for devices.
> >
> This is great and all, but a fair amount of driver code explicitly 
> searches the tree, rather than registering a probe function. That's why 
> our earlier patches in this area were more comprehensive.
> 
> What are your thoughts on handling those cases?

One by one.  Trying to handle the explicit searches automagically is
just asking for trouble.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
