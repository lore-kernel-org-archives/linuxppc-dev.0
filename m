Return-Path: <nathanl@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7521E67A41
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 13:22:51 +1100 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0cAni002759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:38:10 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0bunR001833
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:37:56 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L0bkOM229276
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:37:46 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2L0bkkx016343
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:37:46 -0500
Subject: [PATCH 0/7] powerpc numa updates and fixes
In-Reply-To: 
Date: Mon, 20 Mar 2006 18:33:45 -0600
Message-Id: <1142901225978-git-send-email-nathanl@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: Nathan Lynch <nathanl@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following series has some minor bugfixes and updates for numa for
2.6.17.

Tested on Power4 (lpar and non-) and Power5.


 numa.c |  156 +++++++++++++++++++++--------------------------
 1 files changed, 72 insertions(+), 84 deletions(-)
