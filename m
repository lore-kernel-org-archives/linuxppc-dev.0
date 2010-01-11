Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 2F530B7BF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:06:30 +1100 (EST)
Received: by ywh39 with SMTP id 39so20225708ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 11:06:28 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220757.44591.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220757.44591.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 12:06:08 -0700
Message-ID: <fa686aa41001111106w1548ea04pd20e12b31d3dac65@mail.gmail.com>
Subject: Re: [PATCH 01/13] powerpc/5200: LocalPlus driver: fix indentation and
	white space
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Roman.

I'm finally getting some time to look at these with a bit more detail.

On Mon, Dec 21, 2009 at 11:57 PM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 18 +++++++++------=
---
> =A01 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index 929d017..4c84aa5 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -165,7 +165,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
>
> =A0 =A0 =A0 =A0bit_fields =3D req->cs << 24 | 0x000008;
> =A0 =A0 =A0 =A0if (!write)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D 0x010000; /* read mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D 0x010000; /* read mode */
> =A0 =A0 =A0 =A0out_be32(lpbfifo.regs + LPBFIFO_REG_CONTROL, bit_fields);
>
> =A0 =A0 =A0 =A0/* Kick it off */
> @@ -279,7 +279,7 @@ static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void =
*dev_id)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_callback =3D 1;
>
> - out:
> +out:

The label 1 space indentation is intentional so coax diff into
choosing the right line for the function name.  There are plenty of
examples of this in the kernel.

The rest of the changes are valid, but unimportant.  It's not worth
the effort.  In most cases I don't bother fixing whitespace unless
they style violations are so gratuitous  that it is hard to read the
code otherwise, or if I'm already touching the offending line.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
