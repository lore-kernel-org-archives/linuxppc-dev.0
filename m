Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85BE82C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 22:27:19 +1000 (EST)
Received: from mail22-tx2 (localhost [127.0.0.1])	by mail22-tx2-R.bigfish.com
 (Postfix) with ESMTP id B2B3EA02B5	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 10 Sep 2012 12:27:14 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.246])	by
 mail22-tx2.bigfish.com (Postfix) with ESMTP id 7E89BC0216	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 12:27:11 +0000 (UTC)
Received: from [43.194.30.232] ([43.194.30.232]:38891 "EHLO
 wymx1.eu.sony.com")	by mx3.eu.sony.com with ESMTP id S54736Ab2IJM1J (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);	Mon, 10 Sep 2012 13:27:09 +0100
Received: from gb-bas-dc-dx1.eu.sony.com ([43.194.30.31]:51613 "EHLO
 gbise0weymsx02.eu.sony.com") by wymx1.eu.sony.com with ESMTP	id
 S61772Ab2IJM1J convert rfc822-to-8bit (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);	Mon, 10 Sep 2012 13:27:09 +0100
Date: Mon, 10 Sep 2012 14:27:01 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: <geert@sonytel.be>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 4/5] powerpc: Rework set_dabr so it can take a DABRX
 value as well
In-Reply-To: <25431.1346996581@neuling.org>
Message-ID: <alpine.DEB.2.00.1209101426170.2559@bushbaby.sonytel.be>
References: <1346908671-7464-1-git-send-email-mikey@neuling.org>
 <1346908671-7464-4-git-send-email-mikey@neuling.org>
 <CAMuHMdU=UjkU3BRV7Aouu-m=vKaSPWH93Rkh6L3RWev4oM5jYA@mail.gmail.com>
 <15813.1346989072@neuling.org>
 <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
 <25431.1346996581@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


    Hi Mikey,

On Fri, 7 Sep 2012, Michael Neuling wrote:
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > On Fri, 7 Sep 2012, Michael Neuling wrote:
> > > Do you know if the ps3 hypervisor will allow us to set DABRX_BTI or
> > > DABRX_HYP?  phyp wont. =20
> >=20
> > According to the documenation, all bits but DABRX_USER, DABRX_KERNEL,=
 and
> > DABRX_BTI must be zero.  This implies DABRX_HYP cannot be set.
> >=20
> > BTW, the requirement that DABRX_USER and DABRX_KERNEL cannot both be =
zero
> > at the same time is also there, cfr. your comment and check in
> > pseries_set_xdabr().
> >=20
> > Unfortunately, I cannot test it.
>=20
> OK thanks, I'll mask appropriately.
>=20
> Any place we can get a copy of the PS3 HV doc you're quoting from?

I'm afraid not.

With kind regards,

Geert Uytterhoeven
Software Architect
Technology and Software Centre Europe

Sony Belgium, bijkantoor van Sony Europe Limited.
Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=B7 Belgium

Phone:  +32 (0)2 700 8453
Fax:    +32 (0)2 700 8622
E-mail: Geert.Uytterhoeven@sonycom.com

Sony Europe Limited. A company registered in England and Wales.
Registered office: The Heights, Brooklands, Weybridge, Surrey. KT13 0XW.
                   United Kingdom
