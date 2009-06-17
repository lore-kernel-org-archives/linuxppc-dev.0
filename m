Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E8502B7195
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 15:54:14 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904160646v75a98e02s446fd89c08cfebae@mail.gmail.com>
References: <1239883845-17804-1-git-send-email-sr@denx.de>
	<fa686aa40904160626k118cea3cvc0db38a2277e45b8@mail.gmail.com>
	<200904161537.59048.sr@denx.de>
	<fa686aa40904160646v75a98e02s446fd89c08cfebae@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Jun 2009 23:53:51 -0600
Message-ID: <fa686aa40906162253j76776e88y9d7c818f4d0f1508@mail.gmail.com>
Subject: Re: [PATCH 1/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
To: Stefan Roese <sr@denx.de>, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 7:46 AM, Grant Likely<grant.likely@secretlab.ca> wr=
ote:
> On Thu, Apr 16, 2009 at 7:37 AM, Stefan Roese <sr@denx.de> wrote:
>> On Thursday 16 April 2009, Grant Likely wrote:
>>> > Signed-off-by: Stefan Roese <sr@denx.de>
>>> > Reviewd-by: Grant Likely <grant.likely@secretlab.ca>
>>>
>>> Yup, still looks good to me. =A0What boards has this been tested on?
>>
>> I tested this version on PPC405EX Kilauea equipped only one "standard"
>> Spansion S29GL512 NOR chip. And a slightly modified version on an MPC836=
0
>> board (kmeter1) which is equipped with the Intel P30 part mentioned in t=
he
>> bindings description. Slightly modified since this board support is not =
yet
>> pushed upstream and currently using v2.6.28 (physmap_of.c has received m=
inor
>> modifications after 2.6.28 release).
>
> Okay. =A0It will be good to get this one into -next for some testing
> exposure. =A0Unless he asks me to do otherwise, I'll leave this one to
> David to pick up.

David, what's the status of this patch?  Will it be merged for 2.6.31?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
