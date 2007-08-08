Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8118DDEFC
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 05:59:20 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78JxH8G031291
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 15:59:17 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78JxHQ0551976
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 15:59:17 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78JxH52018786
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 15:59:17 -0400
Date: Wed, 8 Aug 2007 14:59:16 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/6] pseries: rtas & nvram cleanup/simpilification
Message-ID: <20070808195916.GA20055@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,

Please apply te following for 2.6.24

The following sequence of patches cleanup, simplify and shorten
the pseries code having to do with error logging. Several
global variables shared across directories are removed, and
the rtasd initialization sequence is rearranged and simplified,
making the flow of control clearer. A minor buglet is fixed,
and error mesages can now be logged earlier in the boot sequence.

--linas
 
