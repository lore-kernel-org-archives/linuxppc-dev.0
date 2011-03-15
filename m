Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03D89B6FE1
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 03:00:16 +1100 (EST)
Subject: Re: [PATCH] I2C: Add support for 64bit system.
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTim0_ttjDPJvx71B-=Ze5dRTrKXfpavx7gxvYr5p@mail.gmail.com>
Date: Tue, 15 Mar 2011 11:00:03 -0500
Message-Id: <FCEF0E17-0110-457C-A449-782FC01B37C3@kernel.crashing.org>
References: <1292830654-7056-1-git-send-email-B33228@freescale.com>
	<20101220145954.GA1126@trinity.fluff.org>
	<D9BF0938-44B1-4BB8-BF3C-0A9CB44B9CC5@kernel.crashing.org>
	<AANLkTim0_ttjDPJvx71B-=Ze5dRTrKXfpavx7gxvYr5p@mail.gmail.com>
To: Timur Tabi <timur.tabi@gmail.com>
Cc: Xulei <B33228@freescale.com>, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-i2c@fluff.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 15, 2011, at 10:56 AM, Timur Tabi wrote:

> On Tue, Mar 15, 2011 at 10:44 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>> On Dec 20, 2010, at 8:59 AM, Ben Dooks wrote:
>>=20
>>> On Mon, Dec 20, 2010 at 03:37:34PM +0800, Xulei wrote:
>>>> Currently I2C_MPC supports 32bit system only, then this
>>>> modification makes it support 32bit and 64bit system both.
>>>>=20
>>>> Signed-off-by: Xulei <B33228@freescale.com>
>>>=20
>>> This been build or run tested?
>>=20
>> Yes, Any issues with me applying this via the powerpc.git tree?
>=20
> I'm concerned about the fact that we have to have two defines to
> declare code that is 32-bit and 64-bit clean.  Technically speaking,
> all drivers should work in both environments.  It seems silly to have
> "PPC32 || PPC64" for everything.  Isn't there a generic "PPC" config
> option that covers this?

There is, I'll post a new patch that uses it.

- k=
