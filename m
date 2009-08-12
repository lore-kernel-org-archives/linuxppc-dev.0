Return-Path: <Paul.Gortmaker@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4B248B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 01:08:01 +1000 (EST)
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AF77DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 01:07:59 +1000 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id n7CDYq0d025213
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 06:34:52 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] sbc834x update; PCI IRQ fix, enable MTD, USB
Date: Wed, 12 Aug 2009 09:34:27 -0400
Message-Id: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a handful of small sbc834x patches, entirely limited in
scope to this board's DTS/defconfig.  Aside from the PCI IRQ
mis-assignment fix, the other changes are aimed at improving the
general functionality of the board out of the box, by enabling
MTD and USB storage.

Paul.
