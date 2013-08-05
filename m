Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x234.google.com (mail-lb0-x234.google.com
 [IPv6:2a00:1450:4010:c04::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BBE92C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 03:58:12 +1000 (EST)
Received: by mail-lb0-f180.google.com with SMTP id a16so2281057lbj.25
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 10:58:02 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
Date: Mon, 5 Aug 2013 10:58:01 -0700
Message-ID: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
Subject: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have a PCI card (a Netgear FA331, vendor:device 100b:0020) that is
failing to be detected by our PPC platform.  This device works just
fine in a PC, and other cards work just fine in the same PCI slot (we
have an Intel 82540EM based card that works).

But for some reason, neither u-boot nor the kernel detect this card.
Any ideas why this might be?

Thanks,
Pete
