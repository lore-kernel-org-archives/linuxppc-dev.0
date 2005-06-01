Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1117645131.6517.31.camel@cashmere.sps.mot.com>
References: <1117614390.19020.24.camel@gaston>
	<1117645131.6517.31.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 07:56:48 +1000
Message-Id: <1117663009.19020.61.camel@gaston>
Mime-Version: 1.0
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Booting the linux-ppc64 kernel & flattened device tree v0.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-06-01 at 11:58 -0500, Jon Loeliger wrote:
> On Wed, 2005-06-01 at 03:26, Benjamin Herrenschmidt wrote:
> > Here's the fourth version of my document along with new kernel patches
> > for the new improved flattened format, and the first release of the
> > device-tree "compiler" tool. The patches will be posted as a reply to
> > this email. The compiler, dtc, can be downloaded, the URL is in the
> > document.
> 
> Ben,
> 
> Does it make sense to do this as well?

You mean include lsprop ? Well, I have another version of lsprop hacked
here that can generate a "source", but dtc can do it too now ... I think
we may just make dtc able to output in "lsprop" format too :) But I'll
talk to david (CC'd, he's the author of dtc).

Ben.
