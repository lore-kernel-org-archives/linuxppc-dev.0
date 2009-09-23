Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4AAD8B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 23:48:53 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8NDg4KH005802
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:42:04 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8NDmn2S155088
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:48:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8NDmmf2022375
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:48:48 -0400
Received: from zod.rchland.ibm.com ([9.49.202.222])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n8NDmirc021980
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:48:47 -0400
Date: Wed, 23 Sep 2009 09:48:44 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] 4xx xmon fixes
Message-ID: <20090923134844.GF14261@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

A couple of simple fixes to improve xmon usage on 4xx boards.  I have no idea
if anyone else even uses this, but I find it handy from time to time.

josh
