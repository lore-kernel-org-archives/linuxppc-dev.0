From: "Rick Hunnicutt" <rhunnicu@getntds.com>
To: <ghannon@cspi.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: VME driver (Universe II)
Date: Thu, 25 Jul 2002 13:58:14 -0700
Message-ID: <001601c2341d$ff0e0500$cdf859c7@get.com>
In-Reply-To: <85256C01.006330D5.00@pine.cspi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The vme driver I have is from the 5100 lsp MVista provided. It's running
under the 2.4.2 kernel and been exercised pretty extensively. I'm not doing
any DMA transfer though.

Did you have any special setup files (arch/ppc/kernel) for the 5100?

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> ghannon@cspi.com
> Sent: Thursday, July 25, 2002 11:17 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: VME driver (Universe II)
>
>
>
> Greetings,
>
> Has the universe II driver been updated against the 2_4_devel tree?
>
> I have found the patches from Gabriel Paubert, against 2_2.
> Should I attempt to merge that into the 2.4.11 area to get a
> driver for VME?   It would be a learning experience for me, but
> one that I'd rather avoid if possible.
>
> The board is MVME-5100 using 2.4.11 from the devel tree.
>
> Any pointers would be appreciated.
>
> Thanks,
> Gary
>
> Gary Hannon
> CSPI
> (978)663-7598 x1509
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
