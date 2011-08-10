Return-Path: <xenidis@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87500B6F8F
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 03:31:20 +1000 (EST)
Received: by ywb3 with SMTP id 3so816413ywb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 10:31:16 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: union/struct representations for MAS Registers
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <9FE83BDE-592D-42FC-B2B4-A2B6E7E49206@kernel.crashing.org>
Date: Wed, 10 Aug 2011 12:31:12 -0500
Message-Id: <5CE12265-52CB-45B2-91D2-21FEEE058D56@pobox.com>
References: <B952E5AF-98EF-46CE-B30F-7E1EA55C33AC@pobox.com>
	<9FE83BDE-592D-42FC-B2B4-A2B6E7E49206@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2011, at 12:25 PM, Kumar Gala wrote:

>=20
> On Aug 10, 2011, at 12:21 PM, Jimi Xenidis wrote:
>=20
>> I have some and use them in some code, they represent ISA 2.06 MAVN=3D1=
 (version 2)
>> Can I keep them?
>> if so, should I put them somewhere useful to others?
>>=20
>> Examples:
>> union mas1 {
>> 	u32 _val;
>> 	struct {
>> 		u32 v:1;
>> 		u32 iprot:1;
>> 		u32 tid:14;
>> 		u32 _reserved_1:2;
>> 		u32 ind:1;
>> 		u32 ts:1;
>> 		u32 tsize:4;
>> 		u32 _reserved_2:8;
>> 	};
>> };
>=20
> Uugh, we really have avoided unions for such things and it would be =
nice to keep it that way.

I like "nice", I'll convert
-JX


>=20
> - k
