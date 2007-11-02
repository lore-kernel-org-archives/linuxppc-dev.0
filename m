Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8363DDDE03
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 07:20:04 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA2KJwHl022046
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 16:19:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA2KJvrr128812
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 16:19:57 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA2KJvwV022795
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 16:19:57 -0400
Date: Fri, 2 Nov 2007 15:19:57 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] powerpc eeh: bug fixes for crashes, bad handling
Message-ID: <20071102201957.GU2183@austin.ibm.com>
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

Hi Paul,

Please forward upstream the following three tiny patches 
for EEH bugs, including on crash, and one failure to 
reset correctly.

(I was planning on blasting you many many more patches,
involving MSI, but have had nothing but broken hardware
for the last few weeks, and so have nothing to show. 
Dang, cause I needed the msi fixes for 2.6.24. Oh well.)

--linas
