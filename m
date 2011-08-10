Return-Path: <xenidis@gmail.com>
Received: from mail-pz0-f44.google.com (mail-pz0-f44.google.com
	[209.85.210.44]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B765DB70C3
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 03:21:27 +1000 (EST)
Received: by pzk36 with SMTP id 36so2280026pzk.3
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 10:21:25 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
Content-Type: text/plain; charset=us-ascii
Subject: union/struct representations for MAS Registers
Date: Wed, 10 Aug 2011 12:21:21 -0500
Message-Id: <B952E5AF-98EF-46CE-B30F-7E1EA55C33AC@pobox.com>
To: Kumar Gala <galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have some and use them in some code, they represent ISA 2.06 MAVN=3D1 =
(version 2)
Can I keep them?
if so, should I put them somewhere useful to others?

Examples:
union mas1 {
	u32 _val;
	struct {
		u32 v:1;
		u32 iprot:1;
		u32 tid:14;
		u32 _reserved_1:2;
		u32 ind:1;
		u32 ts:1;
		u32 tsize:4;
		u32 _reserved_2:8;
	};
};

-jx
