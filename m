Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20091125.232818.-1350498258.imp@bsdimp.com>
References: <20091124081827.6216.1896.stgit@angua>
	<1259207974.16367.226.camel@pasglop>
	<fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
	<20091125.232818.-1350498258.imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 18:06:11 +1100
Message-ID: <1259219171.16367.331.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-25 at 23:28 -0700, M. Warner Losh wrote:
> In message:
> <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
>             Grant Likely <grant.likely@secretlab.ca> writes:
> : Word from Mitch is the device tree is network byte order.  period.
> 
> OpenFirmware defines the order to be big endian always, even on little
> endian processors.

Right, that's the only sane way to do it, I just didn't remember off
hand what was said in the OF spec :-)

Cheers,
Ben.
