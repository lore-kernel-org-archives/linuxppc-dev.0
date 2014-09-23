Return-Path: <simon.kagstrom@netinsight.net>
Received: from ernst.netinsight.se (ernst.netinsight.se [194.16.221.21])
 by lists.ozlabs.org (Postfix) with SMTP id 5B2271A000F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 18:56:32 +1000 (EST)
Date: Tue, 23 Sep 2014 10:56:16 +0200
From: Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?= <simon.kagstrom@netinsight.net>
To: <linuxppc-dev@lists.ozlabs.org>, <grant.likely@linaro.org>,
 <geert@linux-m68k.org>, <scottwood@freescale.com>
Subject: Re: [PATCH v2] PowerPC: boot: Parse chosen/cmdline-timeout parameter
Message-ID: <20140923105616.0dd666ff@marrow.netinsight.se>
In-Reply-To: <20140909164006.0e3593f0@marrow.netinsight.se>
References: <20140909164006.0e3593f0@marrow.netinsight.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi again!

On Tue, 9 Sep 2014 16:40:06 +0200
Simon K=C3=A5gstr=C3=B6m <simon.kagstrom@netinsight.net> wrote:

> A 5 second timeout during boot might be too long, so make it
> configurable. Run the loop at least once to let the user stop the boot
> by holding a key pressed.
>=20
> The property is added to the chosen node, e.g.,
>=20
> 	chosen {
> 		bootargs =3D "console=3DttyUL0 root=3D/dev/ram0";
> 		linux,stdout-path =3D "/plb@0/serial@46000000";
> 		linux,cmdline-timeout =3D <100>;
> 	} ;
>=20
> Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
> ---
>=20
> ChangeLog:
>=20
> v2:
> - Rename the property linux,cmdline-timeout (Grant Likely)
> - Run the loop at least once to allow (Grant Likely)

Sorry to bother the list, but it would be nice if this patch could
trickle down into some tree if it's seen as acceptable. So consider
this a ping :-)

>  arch/powerpc/boot/main.c   |   11 ++++++++++-
>  arch/powerpc/boot/ops.h    |    2 +-
>  arch/powerpc/boot/serial.c |    6 +++---
>  3 files changed, 14 insertions(+), 5 deletions(-)

[...]

Thanks,
// Simon
