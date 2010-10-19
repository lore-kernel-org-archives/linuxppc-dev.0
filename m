Return-Path: <Horst.KRONSTORFER@frequentis.com>
Received: from mail1.frequentis.com (mail1.frequentis.com [212.186.194.131])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "spamquarantine.frequentis.frq",
	Issuer "Frequentis Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 79C7AB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 19:26:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [QUESTION] MPC8343 'internal only' DMA support
Date: Tue, 19 Oct 2010 10:15:09 +0200
Message-ID: <2E0C184B35151B4690232FF6CFE53FE501569473@VIECLEX02.frequentis.frq>
From: "KRONSTORFER Horst" <Horst.KRONSTORFER@frequentis.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi!

i assume the mpc8343 dma controllers ability to do internally controlled
operations (csb/csb)
is _not_ affected by deactivating externally controlled operations via
pinmultiplexing in sicrl.

am I correct?=20

thanks
horst kronstorfer
