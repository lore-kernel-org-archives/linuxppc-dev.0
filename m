Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 53393B6F8A
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 05:40:38 +1100 (EST)
Subject: Re: [PATCH] uio: Support 36-bit physical addresses on 32-bit systems
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111012161931.GE21852@local>
Date: Wed, 12 Oct 2011 13:40:22 -0500
Message-Id: <38B65690-DA92-4923-B2A4-6523DDDA579A@kernel.crashing.org>
References: <1318430145-19898-1-git-send-email-galak@kernel.crashing.org>
 <20111012153229.GB21852@local> <20111012161931.GE21852@local>
To: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de,
 Kai Jiang <Kai.Jiang@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2011, at 11:19 AM, Hans J. Koch wrote:

> On Wed, Oct 12, 2011 at 05:32:29PM +0200, Hans J. Koch wrote:
>> On Wed, Oct 12, 2011 at 09:35:45AM -0500, Kumar Gala wrote:
>>> From: Kai Jiang <Kai.Jiang@freescale.com>
>>>=20
>>> To support >32-bit physical addresses for UIO_MEM_PHYS type we need =
to
>>> extend the width of 'addr' in struct uio_mem.  Numerous platforms =
like
>>> embedded PPC, ARM, and X86 have support for systems with larger =
physical
>>> address than logical.
>>>=20
>>> Since 'addr' may contain a physical, logical, or virtual address the
>>> easiest solution is to just change the type to 'unsigned long long'
>>> regardless of which type is utilized.
>>=20
>> No. There's phys_addr_t for that purpose, defined in =
include/linux/types.h.
>> Please use that.
>=20
> I forgot: If you resend this, please update the documentation as well.
> (Documentation/DocBook/uio-howto.tmpl)

What would you look added or modified here?

- k=
