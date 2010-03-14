Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 013D6B7D58
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 21:48:11 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp01.in.ibm.com (8.14.3/8.13.1) with ESMTP id o2EAm8Ld014716
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 16:18:08 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2EAm8fs3080252
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 16:18:08 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2EAm8ef015856
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 16:18:08 +0530
Message-ID: <4B9CBEE6.1090509@in.ibm.com>
Date: Sun, 14 Mar 2010 16:18:06 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: 34-rc1-git3 build failure with CGROUP_MEM_RES_CTLR_SWAP=y
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: lizf@cn.fujitsu.com, nishimura@mxp.nes.nec.co.jp,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a PowerPC box, latest 34-rc1 git(d89b218b8...) fails to build
with CGROUPS_MEM_RES_CTRL_SWAP=y. 

LD      init/built-in.o
LD      .tmp_vmlinux1
mm/built-in.o: In function __xchg:
arch/powerpc/include/asm/system.h:331: undefined reference to .__xchg_called_with_bad_pointer
mm/built-in.o: In function __cmpxchg:
arch/powerpc/include/asm/system.h:474: undefined reference to .__cmpxchg_called_with_bad_pointer
make: *** [.tmp_vmlinux1] Error 1

The code in question was added via commit 024914477e...

memcg: move charges of anonymous swap

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
