Return-Path: <lagrange@fr.oleane.com>
Received: from smtp3.clb.oleane.net (smtp3.clb.oleane.net [213.56.31.19])
	by ozlabs.org (Postfix) with ESMTP id 73EAE67B67
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jul 2006 18:24:56 +1000 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Li Yang-r58472'" <LeoLi@freescale.com>, <pantelis@embeddedalley.com>
Subject: RE: Linux 2.6.x : cpm_dpalloc alignment bug perhaps not fully resolved
Date: Wed, 5 Jul 2006 10:25:55 +0200
Message-ID: <003701c6a00c$a9284c40$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306FA6F52@zch01exm40.ap.freescale.net>
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

Hi Leo,

Thanks for the reply.

The patch, I already applied, comes directly from Pantelis
and is the same code as found at
http://patchwork.ozlabs.org/linuxppc/patch?id=3484

What do you mean by the alignment patch ?

I suspect a problem in the cpm_dpfree function,
not in the cpm_dpalloc function.

I'll try to give more details.

Best regards
Laurent



> -----Message d'origine-----
> De : Li Yang-r58472 [mailto:LeoLi@freescale.com]
> Envoyé : mer. 5 juillet 2006 03:32
> À : Laurent Lagrange; pantelis@embeddedalley.com
> Cc : linuxppc-embedded@ozlabs.org
> Objet : RE: Linux 2.6.x : cpm_dpalloc alignment bug perhaps not fully
> resolved
>
>
> Did you apply the alignment patch too?  AFAIK, the problem is
> never fixed in
> mainstream trees.
>
> Best Regards,
> Leo
>
