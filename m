Return-Path: <Christopher.Varlese@keymile.com>
Received: from mail.ch.keymile.com (mail.ch.keymile.com [193.17.201.103])
	by ozlabs.org (Postfix) with SMTP id 7C4DFDDDDF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Nov 2008 01:02:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help: NOR flash MTD and JFFS2 rootfs
Date: Wed, 19 Nov 2008 15:02:14 +0100
Message-ID: <D839955AA28B9A42A61B9181506E27C4013A0408@SRVCHBER1212.ch.keymile.net>
In-Reply-To: <49241856.1090209@mikroswiat.pl>
References: <D839955AA28B9A42A61B9181506E27C4013A03DC@SRVCHBER1212.ch.keymile.net>
	<49241856.1090209@mikroswiat.pl>
From: "Varlese, Christopher" <Christopher.Varlese@keymile.com>
To: "Dominik Bozek" <domino@mikroswiat.pl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I'm using hexadecimal value for "root". I guess in your case try
"root=3D1f05.

Dominik,

Thank you, that worked!

Aha, so "1f05" is /dev/mtdblock5 addressed via its maj/min dev nums:

~ # ls -l /dev/mtdblock5
brw-r-----    1 root     root      31,   5 Nov 17  2008 /dev/mtdblock5


Best regards
Christopher Varlese
R&D Software
________________________________________=20
KEYMILE AG
Schwarzenburgstrasse 73
3097 Bern, Switzerland
www.keymile.com
