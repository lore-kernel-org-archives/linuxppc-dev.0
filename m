Return-Path: <afleming@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZWJ71nYszDsGT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:08:22 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id 133so3854925wmq.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 01:08:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] Cyrus: create a defconfig
From: Andy Fleming <afleming@gmail.com>
In-Reply-To: <DB5PR0401MB19281D6D9CFE4352E21E57A091FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Date: Thu, 15 Sep 2016 09:08:18 +0100
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 "aperez@alexperez.com" <aperez@alexperez.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <BED93BF7-B9DB-4D3D-AF72-8DB24ABDB130@gmail.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-4-git-send-email-afleming@gmail.com>
 <DB5PR0401MB1928F23FDFF08F9E1288365691F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <CAKWjMd7kKSyg4Ksn8=T9q6308LNBvRH+YqLcAMqqh=-tqEEy7w@mail.gmail.com>
 <DB5PR0401MB19281D6D9CFE4352E21E57A091FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: Scott Wood <scott.wood@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> On Sep 12, 2016, at 18:54, Scott Wood <scott.wood@nxp.com> wrote:
>=20
>> On 09/10/2016 05:12 PM, Andy Fleming wrote:
>>=20
>>=20
>> On Tuesday, September 6, 2016, Scott Wood <scott.wood@nxp.com
>> <mailto:scott.wood@nxp.com>> wrote:
>>=20
>>>    On 09/06/2016 02:12 PM, Andy Fleming wrote:
>>> This sets up the proper config elements for Power and Reset to work
>>> properly (using the gpio pins).
>>>=20
>>> Signed-off-by: Andy Fleming <afleming@gmail.com <javascript:;>>
>>> ---
>>> arch/powerpc/Makefile                      | 5 +++++
>>> arch/powerpc/configs/cyrus_basic_defconfig | 9 +++++++++
>>> 2 files changed, 14 insertions(+)
>>> create mode 100644 arch/powerpc/configs/cyrus_basic_defconfig
>>=20
>>    Why does cyrus need its own defconfig?  Just enable the power/reset
>>    stuff in 85xx-hw.config.
>>=20
>>=20
>>=20
>>    Ok.
>=20
> Please send non-HTML mail with proper quote markers.  It's hard to read
> when it looks like someone is talking to themself.

Argh, sorry. gmail iPhone client did that very subtly. I've flipped it over t=
o Mail, and hopefully that fixes it...

Andy=
