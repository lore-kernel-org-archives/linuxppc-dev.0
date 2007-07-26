Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1220EDDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 08:29:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6QMTaEv018121
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:29:36 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6QMTa5S193370
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:29:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6QMTZJl008175
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:29:35 -0600
Date: Thu, 26 Jul 2007 17:29:35 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] powerpc/eeh: for 2.6.23: a fix for bridges, and tweaks
Message-ID: <20070726222935.GJ9876@austin.ibm.com>
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

The following three patches should be low impact, and I think they could
go into 2.6.23 if its not too late.

-- two are formating/printing fixes/enhancements

-- one fixes the way PCI cards with bridges are handled;
   in particular, it avoids a nll pointer deref, so is a serious bugfix.


Linas.
