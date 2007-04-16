Return-Path: <glikely@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.179])
	by ozlabs.org (Postfix) with ESMTP id 7A515DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 00:06:29 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so1559903ika
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 07:06:28 -0700 (PDT)
Message-ID: <528646bc0704160706j7362b395jc79cebeb20be3f03@mail.gmail.com>
Date: Mon, 16 Apr 2007 08:06:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] mpc5200: lite5200(b) dts fixes
In-Reply-To: <20070416071010.GI18236@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070416071010.GI18236@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/16/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Three trivial DTS fixes:
> Mark Lite5200(b) boards as "mpc5200" compatible. On efika the
> firmware already does that.
> Fix mscan interrupt.
> Fix wakeup GPIO address.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>
> ---
> --- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
> +++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
> @@ -49,6 +49,7 @@
>
>         soc5200@f0000000 {
>                 model = "fsl,mpc5200b";
> +               compatible = "mpc5200";

For completeness, this really should be "mpc5200b,mpc5200".  (I should
have caught this earlier; sorry)

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
