Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CBE2DDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 18:09:58 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0I7A9Qa019522
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 18:10:09 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0I79vkp2154686
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 18:09:57 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0I79upw014294
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 18:09:56 +1100
Message-ID: <479050BF.1090107@linux.vnet.ibm.com>
Date: Fri, 18 Jan 2008 12:39:51 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc8-mm1 build failure on headers_check
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
In-Reply-To: <20080117023514.9df393cf.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

The kernel build fails during the headers_check on power box

  CHECK   include/asm/nvram.h
/usr/local/autobench/autotest/tmp/build/linux/usr/include/asm/nvram.h requires linux/list.h, which does not exist in exported headers
make[3]: *** [/usr/local/autobench/autotest/tmp/build/linux/usr/include/asm/.check.nvram.h] Error 1
make[2]: *** [asm-powerpc] Error 2
make[1]: *** [headers_check] Error 2
make: *** [vmlinux] Error 2

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
