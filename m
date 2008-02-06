Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6C71EDDF79
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 07:36:51 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m16KchYH009102
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 15:38:43 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m16KamoB233504
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 15:36:48 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m16Kam9T030330
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 15:36:48 -0500
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.41.248.175])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m16Kamp8030297
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 15:36:48 -0500
Received: from [9.53.40.161] (dyn95340161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m16KalLU035610
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 14:36:48 -0600
Message-ID: <47AA1A81.5000905@austin.ibm.com>
Date: Wed, 06 Feb 2008 14:37:21 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] [POWERPC] Updates to allow cpu dlpar remove to work again
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches make some small corrections to allow cpu dlpar remove to
work again.  Cpu dlpar remove is currently failing because the cpu we are 
removing may still have irq's pinned to it or have it's CPPR reset during
the cpu teardown process.

-Nathan Fontenot
