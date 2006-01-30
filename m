Return-Path: <nzeitler@osii.com>
Received: from osiemail.osii.com (mail.osii.com [207.67.97.196])
	by ozlabs.org (Postfix) with ESMTP id 73529689AE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 01:31:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC5200 - Problem with PSC mode
Date: Mon, 30 Jan 2006 08:18:56 -0600
Message-ID: <7492B3D3325B424399725C8A03926A3E2592C2@osiemail.osii.com>
From: "Zeitler, Nathan" <nzeitler@osii.com>
To: <allanjos@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Allann,

> out_8(&psc->command, MPC5xxx_PSC_RST_RX |
>          MPC5xxx_PSC_RST_TX |
>          MPC5xxx_PSC_SEL_MODE_REG_1 |
>          MPC5xxx_PSC_RST_ERR_STAT);

It looks like you're trying to do too many things at once here. =20
ORing SEL_MODE_REG_1 and RST_ERR_STAT together=20
forms a completely different command in the Command=20
register.  You may want to break that into two lines of code. =20
Give that a try!

Open Systems International, Inc.=20
Nathan Zeitler
Hardware Engineer
3600 Holly Lane North, Suite 40
Minneapolis, MN 55447-1286
Phone: 763 551 0559
Fax: 763 551 0750
E-mail: nzeitler@osii.com
