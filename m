Return-Path: <B37781@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 16E67B6FE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 18:12:45 +1100 (EST)
Subject: Re: [SDK v1.2][PATCH 1/2 v3] powerpc/85xx: Add dts for P1021RDB-PC
 board
From: Xu Jiucheng <B37781@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4F0B541C.1050001@freescale.com>
References: <1326092022-10085-1-git-send-email-B37781@freescale.com>
 <4F0B541C.1050001@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Jan 2012 15:17:01 +0800
Message-ID: <1326179821.1895.5.camel@xujc-desktop>
MIME-Version: 1.0
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E5=9C=A8 2012-01-09Mon=E7=9A=84 14:54 -0600=EF=BC=8CScott Wood=E5=86=99=E9=
=81=93=EF=BC=9A
> On 01/09/2012 12:53 AM, Xu Jiucheng wrote:
> > +	nand@1,0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "fsl,p1020-fcm-nand",
> > +			     "fsl,elbc-fcm-nand";
>=20
> s/p1020/p1021/
>=20
> -Scott

Ok.

Thanks & Best Regards
Jiucheng
