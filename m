Return-Path: <kumar.gala@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 2B339B70B8
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 01:35:04 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
Date: Sat, 18 Sep 2010 10:34:58 -0500
Message-ID: <70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: linux-watchdog@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 18, 2010, at 9:36 AM, Tabi Timur-B04825 wrote:

> On Sep 17, 2010, at 10:14 PM, "Benjamin Herrenschmidt" =
<benh@kernel.crashing.org> wrote:
>=20
>> On Fri, 2010-09-17 at 20:20 -0500, Timur Tabi wrote:
>>> I don't see any reason to limit it to GPL drivers.  Not only that, =
but
>>> then we'll have this:
>>=20
>> I do
>=20
> Can you elaborate on that, or are you just going to pull rank on me?
>=20
>>=20
>>> EXPORT_SYMBOL(ppc_proc_freq);
>>> EXPORT_SYMBOL_GPL(ppc_tb_freq);
>>>=20
>>> That just looks dumb.=20
>>=20
>> Right, so send a patch to fix the first one too :-)

I don't think either of these should be EXPORT_SYMBOL_GPL.  Why =
shouldn't a binary module be allowed to know these frequencies?  My view =
is why preclude anyone from using this how they want.  If they want to =
live in the gray area so be it.  Who am I to say they shouldn't have =
that choice.

> Then why doesn't someone post a patch to change all EXPORT_SYMBOL to =
EXPORT_SYMBOL_GPL?  And why do we consider EXPORT_SYMBOL to be "broken"?
>=20
> I'm not trying to be a troll, but I see a lot of inconsistency with =
respect to  EXPORT_SYMBOL and EXPORT_SYMBOL_GPL. =20

I'm in agreement with the lack of clarity, it seems to be developer =
whim.

- k
