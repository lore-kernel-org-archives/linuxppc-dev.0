Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id C3661B70AB
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 01:14:20 +1000 (EST)
Received: from mail192-tx2 (localhost.localdomain [127.0.0.1])	by
	mail192-tx2-R.bigfish.com (Postfix) with ESMTP id 019E818A0631	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 15:14:17 +0000 (UTC)
Received: from TX2EHSMHS025.bigfish.com (unknown [10.9.14.235])	by
	mail192-tx2.bigfish.com (Postfix) with ESMTP id 602B2D00076	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 15:13:18 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8IFDEI6020350	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 08:13:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8IFRX6a004652	for <linuxppc-dev@ozlabs.org>;
	Sat, 18 Sep 2010 10:27:33 -0500 (CDT)
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
Message-ID: <AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
In-Reply-To: <1284779678.30449.108.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0 (iPad Mail 7B405)
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
Date: Sat, 18 Sep 2010 09:36:51 -0500
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sep 17, 2010, at 10:14 PM, "Benjamin Herrenschmidt" =
<benh@kernel.crashing.org> wrote:

> On Fri, 2010-09-17 at 20:20 -0500, Timur Tabi wrote:
>> I don't see any reason to limit it to GPL drivers.  Not only that, =
but
>> then we'll have this:
>=20
> I do

Can you elaborate on that, or are you just going to pull rank on me?

>=20
>> EXPORT_SYMBOL(ppc_proc_freq);
>> EXPORT_SYMBOL_GPL(ppc_tb_freq);
>>=20
>> That just looks dumb.=20
>=20
> Right, so send a patch to fix the first one too :-)

Then why doesn't someone post a patch to change all EXPORT_SYMBOL to =
EXPORT_SYMBOL_GPL?  And why do we consider EXPORT_SYMBOL to be "broken"?

I'm not trying to be a troll, but I see a lot of inconsistency with =
respect to  EXPORT_SYMBOL and EXPORT_SYMBOL_GPL. =20
>=20
