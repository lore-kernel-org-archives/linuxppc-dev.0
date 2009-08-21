Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4616AB7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 23:39:06 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7LDbiH3013124
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 09:37:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7LDbgXt185730
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 09:37:42 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7LDbgQB030078
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 09:37:42 -0400
Received: from zod.rchland.ibm.com (sig-9-77-145-175.mts.ibm.com
	[9.77.145.175])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n7LDbeQl029812
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 09:37:42 -0400
Date: Fri, 21 Aug 2009 09:37:40 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: 4xx next branch updated
Message-ID: <20090821133740.GJ2530@zod.rchland.ibm.com>
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

Hi all,

I've rebased the next branch of the 4xx tree to Ben's next branch, and added
the following commits:

Solomon Peachy (1):
      powerpc/40x: Add support for the ESTeem 195E (PPC405EP) SBC

Stefan Roese (2):
      powerpc/44x: Update Arches dts
      powerpc/44x: Update Arches defconfig

fkan@amcc.com (1):
      powerpc/44x: Add Eiger AMCC (AppliedMicro) PPC460SX evaluation board

I'm waiting for a couple more patches, then I'll ask Ben to pull.

josh
