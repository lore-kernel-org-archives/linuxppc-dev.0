Return-Path: <victorgallardo@yahoo.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 599E6B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 06:35:51 +1000 (EST)
Received: from web39807.mail.mud.yahoo.com (web39807.mail.mud.yahoo.com
	[209.191.106.68]) by ozlabs.org (Postfix) with SMTP id 9D793DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 06:35:50 +1000 (EST)
Message-ID: <605613.1808.qm@web39807.mail.mud.yahoo.com>
References: <1250813957-1786-1-git-send-email-fkan@amcc.com>
	<20090821145506.53275701@lappy.seanm.ca>
Date: Fri, 21 Aug 2009 13:35:48 -0700 (PDT)
From: Victor Gallardo <victorgallardo@yahoo.com>
Subject: Re: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for NDFC
	driver.
To: Sean MacLennan <smaclennan@pikatech.com>, Feng Kan <fkan@amcc.com>
In-Reply-To: <20090821145506.53275701@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sean=0A=0A> =0A> It looks like another fix for this bug is to leave the =
current code=0A> alone and turn off CONFIG_MTD_NAND_ECC_SMC.=0A=0AThis=A0wo=
uld fix the problem by hiding the issue. Fengs patch is=A0the correct way t=
o go.=0A=0ABest Regards,=0A=0AVictor Gallardo
