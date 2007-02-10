Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4938DDDEAB
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 11:01:35 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1A01UX6012593
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 19:01:30 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1A01UU5162918
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 19:01:30 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1A01T6T019291
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 19:01:29 -0500
Date: Fri, 9 Feb 2007 18:01:28 -0600
To: jgarzik@pobox.com
Subject: [PATCH 0/5]: spidernet: misc fixes
Message-ID: <20070210000128.GJ5616@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, James K Lewis <jklewis@us.ibm.com>,
	Jens Osterkamp <Jens.Osterkamp@de.ibm.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Jeff, 

A series of five patches against the spidernet ethernet device driver.

The first fixes a compile break in the current kernel.rg tree.
The second restructures the descriptor ring, per an old suggestion.
The third & fourth fix a race condition seen under heavy load.
The fifth is a trite janitorial patch.

Please apply.

--linas
