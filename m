Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 437B5B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 05:56:35 +1000 (EST)
Received: by ewy6 with SMTP id 6so1965489ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 12:56:30 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH V2 0/3] powerpc/83xx cleanup
Date: Fri, 22 Jul 2011 23:55:41 +0400
Message-Id: <1311364544-9413-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a revised version of leftovers from my cleanup efforts for MPC83xx
platform.

Changes since V1:
* Rename mpc83xx_both_init_IRQ to mpc83xx_ipic_and_qe_init_IRQ
* Add powerpc/ prefix to commit messages
