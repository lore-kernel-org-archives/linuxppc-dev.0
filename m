Return-Path: <neorf3k@gmail.com>
Received: from mail-ea0-x232.google.com (mail-ea0-x232.google.com
 [IPv6:2a00:1450:4013:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8339B2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 20:00:29 +1100 (EST)
Received: by mail-ea0-f178.google.com with SMTP id d10so4354138eaj.23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 01:00:24 -0800 (PST)
From: neorf3k <neorf3k@gmail.com>
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Nov 2013 10:00:19 +0100
Subject: Custom board with 5200b and xilinx virtex... how to access...
To: Linux Ppc Dev List Dev List <linuxppc-dev@lists.ozlabs.org>
Message-Id: <59C7F23D-CDC9-4BCB-9D27-510D918FD687@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a custom board with mpc5200b and a xilinx virtex-4. Where could =
we find some information how to integrate it in your linux 2.6.33?
At the moment we have CS4 mapped on it at the address 0x10020000 and we =
are not able to read/write. Via u-boot we can access CS4...
Thank you

Lorenzo=
