Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 2C2C4B70AB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 10:08:35 +1000 (EST)
Received: by yxi11 with SMTP id 11so3798231yxi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Aug 2010 17:08:33 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
	<1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 4 Aug 2010 18:08:13 -0600
Message-ID: <AANLkTinUj=wUhk9qns8X2aUHHv3UpYhoE1yMMr2eMLD+@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] dts: Add sdhci, auto-cmd12 field for p4080 device
	tree
To: Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang <tie-fei.zang@freescale.com> wrote=
:
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> =A0Documentation/powerpc/dts-bindings/fsl/esdhc.txt | =A0 =A02 ++
> =A0arch/powerpc/boot/dts/p4080ds.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
> =A02 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documenta=
tion/powerpc/dts-bindings/fsl/esdhc.txt
> index 8a00407..64bcb8b 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> @@ -14,6 +14,8 @@ Required properties:
> =A0 =A0 reports inverted write-protect state;
> =A0 - sdhci,1-bit-only : (optional) specifies that a controller can
> =A0 =A0 only handle 1-bit data transfers.
> + =A0- sdhci,auto-cmd12: (optional) specifies that a controller can
> + =A0 =A0only handle auto CMD12.

I read this, but I still don't understand what it means.  What does
"auto CMD12" mean?  Are there other kinds of CMD12?  Part of this
might be my ignorance about how eSDHC works, but it could be clearer.

Also, you can feel free to merge this patch with patch 1 in your
series.  I makes sense to update the documentation and the driver at
the same time.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
