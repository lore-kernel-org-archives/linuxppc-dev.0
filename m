Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 644EFDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 05:35:31 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so130212rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 11:35:29 -0700 (PDT)
Message-ID: <fa686aa40810291135i2533f6bk7aeb78ec39e35061@mail.gmail.com>
Date: Wed, 29 Oct 2008 12:35:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "=?ISO-8859-1?Q?Ren=E9_B=FCrgel?=" <r.buergel@unicontrol.de>
Subject: Re: [PATCH] mpc52xx_uart: report serial errors to users
In-Reply-To: <49089BD3.9090705@unicontrol.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <49089BD3.9090705@unicontrol.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Missing patch?

On Wed, Oct 29, 2008 at 11:22 AM, Ren=E9 B=FCrgel <r.buergel@unicontrol.de>=
 wrote:
> Hi! This patch adds the capability to the mpc52xx-uart to report framing
> errors, parity errors, breaks and overruns to userspace. These values may=
 be
> requested in userspace by using the ioctl TIOCGICOUNT.
>
> Signed-off-by: Ren=E9 B=FCrgel <r.buergel@unicontrol.de>
>
> Kind regards, Ren=E9 B=FCrgel
>
> --
> Ren=E9 B=FCrgel
> Software Engineer
> Unicontrol Systemtechnik GmbH
> OT Dittersbach
> Sachsenburger Weg 34
> 09669 Frankenberg
>
> Tel.: 03 72 06/ 88 73 - 19
> Fax: 03 72 06/ 88 73 - 60
> E-Mail: r.buergel@unicontrol.de
> Internet: www.unicontrol.de
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
