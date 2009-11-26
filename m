Return-Path: <imp@bsdimp.com>
Date: Wed, 25 Nov 2009 23:28:18 -0700 (MST)
Message-Id: <20091125.232818.-1350498258.imp@bsdimp.com>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
References: <20091124081827.6216.1896.stgit@angua>
	<1259207974.16367.226.camel@pasglop>
	<fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
            Grant Likely <grant.likely@secretlab.ca> writes:
: Word from Mitch is the device tree is network byte order.  period.

OpenFirmware defines the order to be big endian always, even on little
endian processors.

Warner
