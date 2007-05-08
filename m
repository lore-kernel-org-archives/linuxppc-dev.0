Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F968DDE06
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:09:57 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48M8H8s026086
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 18:08:17 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48N9rVt507130
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:09:53 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48N9rKH005100
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:09:53 -0400
Date: Tue, 8 May 2007 18:09:52 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] powerpc: EEH: extend PCI error logging to dump register
	state
Message-ID: <20070508230952.GN4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, 

Please apply and forward these patches for inclusion in 2.6.22

The following four sets of patches extend the amount of error logging
that is done when a PCI error is detected. This should help in debugging
when the fault is due to a real bug, rather than bad hardware.

--linas
