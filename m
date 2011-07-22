Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3EE17B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 11:53:19 +1000 (EST)
Received: by fxe23 with SMTP id 23so4013339fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 18:53:15 -0700 (PDT)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1311065631-3429-9-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-9-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 21 Jul 2011 21:53:14 -0400
Message-ID: <CAP=VYLr1PLJ1yjAuwWgXSbm-JXSKSBRfX5rZS0VrXad03qErwQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] 85xx/sbc8560: declare that localbus is compatbile
	with simple-bus
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Something has gone off the rails with getmaintainer.pl or similar --
I'm guessing that
PaulM doesn't care about dts patches for some aging sbc8560 board,

P.

On Tue, Jul 19, 2011 at 4:53 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> =A0arch/powerpc/boot/dts/sbc8560.dts | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sb=
c8560.dts
> index 9e13ed8..72078eb 100644
> --- a/arch/powerpc/boot/dts/sbc8560.dts
> +++ b/arch/powerpc/boot/dts/sbc8560.dts
> @@ -331,7 +331,7 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0localbus@ff705000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8560-localbus";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8560-localbus", "sim=
ple-bus";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xff705000 0x100>; =A0 =A0 =A0 //=
 BRx, ORx, etc.
> --
> 1.7.2.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
