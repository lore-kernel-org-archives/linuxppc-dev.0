Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 21E8D2C032A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 11:25:10 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 20 Feb 2014 17:25:08 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 375C93E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 17:25:05 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1L0P5EQ000414
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 01:25:05 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1L0STUs023222
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 17:28:30 -0700
Message-ID: <53069CD9.9090708@linux.vnet.ibm.com>
Date: Thu, 20 Feb 2014 16:24:57 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>,
 Lijun Pan <Lijun.Pan@freescale.com>, Li Zhong <zhong@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Bolle <pebolle@tiscali.nl>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2.1 9/11] powerpc/perf: add kconfig option for hypervisor
 provided counters
References: <1392415338-16288-11-git-send-email-cody@linux.vnet.ibm.com>
 <1392941697-21799-1-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1392941697-21799-1-git-send-email-cody@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whoops, should be "[Patch v2.1 10/11]"
