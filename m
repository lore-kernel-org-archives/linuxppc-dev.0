Return-Path: <NWilson@Airspan.com>
Received: from mail.airspan.com (mail.airspan.com [62.189.116.4])
	by ozlabs.org (Postfix) with ESMTP id C330D2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 18:32:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 11 Nov 2004 07:32:14 -0000
Message-ID: <3506EDCDEC47904CBE6FD2E1DEEA8984020CFB73@fs5.airspan.com>
From: "Neil Wilson" <NWilson@Airspan.com>
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: mmap64/open64/pread etc on 440GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20
> I'm working on some patches to fix 36-bit support for
> io_remap_page_range() and to fix some problems with set_pte()=20
> and friends on 36-bit platforms. This is the first bit=20
> necessary to make this work at all in 2.6. I should be=20
> posting something RSN. ;)
>=20
> -Matt

Okay, thanks for the info.

Guess I will have to put together a simple kernel driver so the hardware
boys can get 36bit access for now.

Neil

--
Neil Wilson
Airspan Communications Ltd.
Cambridge House, Oxford Road,
Uxbridge, Middx, UB8 1UN, UK.
Tel: +44(0)1895-467265

neilwilson@airspan.com
www.airspan.com
