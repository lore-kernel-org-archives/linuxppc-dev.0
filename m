Return-Path: <NWilson@Airspan.com>
Received: from mail.airspan.com (mail.airspan.com [62.189.116.15])
	by ozlabs.org (Postfix) with SMTP id 0ACF2DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 21:50:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: arch/powerpc 440GX external IRQ
Date: Fri, 1 Feb 2008 10:19:40 -0000
Message-ID: <31FE7326559B534EA6C03ACF19B25A31013E85AE@fs5.airspan.com>
From: "Neil Wilson" <NWilson@Airspan.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Does anyone have these working and/or is able to talk me through the DTS
structure for them please ?
I have a 440GX board that works fine under arch/ppc with external
IRQ4,5,6 however I cannot get it correct in the DTS, I think I am not
correctly specifying the cascade of the UIC ?  I started off using the
Taishan DTS as a template as that seems to be the only 440GX in
powerpc/platforms and can get the board to boot, mount NFS etc.

Thanks.

Neil

--
Neil Wilson
Principal Engineer, Embedded Software
Airspan Communications Ltd
Cambridge House, Oxford Road
Uxbridge, Middlesex, UB8 1UN, UK.
+44(0)1895-467265
nwilson@airspan.com=20
