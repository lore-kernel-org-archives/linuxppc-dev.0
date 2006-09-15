Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1F5A667A3A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 03:38:00 +1000 (EST)
Date: Fri, 15 Sep 2006 21:37:51 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/7]Add support for CPM2 peripherals and 8560 eval board
Message-ID: <20060915213751.128e85f3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following series implements the generic cpm2 infrastructure port,
mpc8560 board-specific bits, and an attempt to overhaul and get rid
of some stuff moved along from the 2.4 times.

This version has refined devtree, and all the received with the initial submission 
comments addressed.

Paul: This is for the next merge window...

--
Sincerely, Vitaly
