Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 47B2BB7C1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 00:48:05 +1000 (EST)
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
	[209.85.211.180]) by ozlabs.org (Postfix) with ESMTP id A2AAEDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 00:48:04 +1000 (EST)
Received: by ywh10 with SMTP id 10so728521ywh.1
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 07:48:03 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AAE5416.3040908@denx.de>
References: <4AADF93C.3030604@denx.de>
	<fa686aa40909140643j3183e181x49be002941ae5c36@mail.gmail.com>
	<4AAE5416.3040908@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Sep 2009 08:47:43 -0600
Message-ID: <fa686aa40909140747y1d6648c2x86406feb3edbfc72@mail.gmail.com>
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board mucmc52
To: hs@denx.de
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2009 at 8:32 AM, Heiko Schocher <hs@denx.de> wrote:
> Grant Likely wrote:
>> On Mon, Sep 14, 2009 at 2:05 AM, Heiko Schocher <hs@denx.de> wrote:
>>> + =A0 =A0 =A0 soc5200@f0000000 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5200-immr";
>>
>> Does this board use the older and rarer non-'B' mpc5200 part? =A0If not,
>> then fsl,mpc5200b-immr also needs to be in this list.
>
> OK, I add this too

Okay, then before you resubmit, do a side-by-side comparison between
this file and one of the existing mpc5200b dts files.  There are
numerous fsl,mpc5200b-* compatible values that need to be present.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
