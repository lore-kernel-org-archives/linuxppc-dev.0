Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E3DCEDDE0E
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 04:17:06 +1100 (EST)
Date: Thu, 4 Dec 2008 12:17:01 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	<linux-mtd@lists.infradead.org>, <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ndfc driver
Message-ID: <20081204121701.5ef90226@lappy.seanm.ca>
In-Reply-To: <20081204090107.20269571@zod.rchland.ibm.com>
References: <20081203222832.3fc77d28@lappy.seanm.ca>
	<20081204090107.20269571@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 4 Dec 2008 09:01:07 -0500
"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:

> On Wed, 3 Dec 2008 22:28:32 -0500
> Sean MacLennan <smaclennan@pikatech.com> wrote:
> 
> Hi Sean,
> 
> A couple of comments/requests below.
> 
> In addition to an example DTS patch (probably to warp itself), could
> you briefly write up a binding and put it in
> Documentation/powerpc/dts-bindings/amcc (or similar)?  Also please CC
> the devicetree-discuss list on that part.

The DTS patch was a separate email to the linuxppc-dev list. I'll try to
find it.

I will look into writing up the binding.

> Looking over the patch it seems pretty straight-forward and I don't
> see anything immediately wrong with it.  You do have a number of
> semi-unrelated changes to the actual port to of_platform though, like
> the s/__raw_writel/out_be32 stuff, the addition of partition parsing,
> etc.  I'm wondering if you could do those fixups separately from the
> actual port.
> 
> Also, could you document why the data structures changed as they did
> in the changelog or perhaps in a summary email.

The __raw_writel changes where from feedback from this list. I will try
to find the email.

This patch originally goes back to January... so I have problems
remembering why all the changes where made ;) Believe it or not, we
have gone through 3 or 4 repositories since then. Finding history is
basically impossible :( So I have to try to rely on an email trail.

> You also seem to only support a single NAND chip, however the NDFC can
> support multiple chips.  Have you looked at how the the fsl_elbc_nand
> driver does multiple chip support?  If not, could you at least
> document the limitation in the patch?

I will document the limitation. I do not have access to a board with
multiple chips and I don't like submitting something I can't test.

Cheers,
   Sean
