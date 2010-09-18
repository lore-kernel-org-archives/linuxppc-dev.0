Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id C76C5B70AE
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 03:46:23 +1000 (EST)
Received: by wyf19 with SMTP id 19so404604wyf.15
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 10:46:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5610599F537DD74A8D1F5CC946A75073034792F7@az33exm25.fsl.freescale.net>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
	<AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>
	<5610599F537DD74A8D1F5CC946A75073034792F7@az33exm25.fsl.freescale.net>
Date: Sat, 18 Sep 2010 13:46:21 -0400
Message-ID: <AANLkTimSewEEhbBoBb+fpPgY9EbE5bWsknPS7OkQgkcy@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
From: Josh Boyer <jwboyer@gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <kumar.gala@freescale.com>,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 18, 2010 at 1:36 PM, Tabi Timur-B04825 <B04825@freescale.com> w=
rote:
> Josh Boyer wrote:
>> It is not, in my opinion, about what is technically possible and what
>> isn't.=A0 The kernel is licensed under the GPL.=A0 This is a Linux kerne=
l
>> only symbol.=A0 One would be hard pressed to claim they have a driver
>> that wasn't written for Linux that happens to need that symbol.=A0 As a
>> member of the Linux kernel community, I find it important to encourage
>> the contribution of code back to the kernel, and this is one way to
>> help that.=A0 This isn't BSD.
>
> Fine, but this goes back to my original question -- if this is how the
> community feels, then why hasn't someone posted a patch that converts all
> EXPORT_SYMBOL into EXPORT_SYMBOL_GPL?

Because of history in a lot of cases, and like all communities,
opinions vary.  I did say this was my opinion, not a mandate of some
sort.

> Either we allow non-GPL drivers, or we don't.=A0 If we don't, then we nee=
d to
> eliminate EXPORT_SYMBOL once and for all.=A0 Otherwise, the message is
> hypocritical.

I'd be all for it.  I don't think it is as black and white as that
though, as nothing rarely is.  (we can't even get all the code to
adhere to the < 80 column "rule" ).  I also don't think it is
necessarily hypocritical.  This is a new symbol being exported, not
one that has been exported for years.

josh
