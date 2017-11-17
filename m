Return-Path: <anthony.yznaga@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydMDY5yHczDrDk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 13:16:29 +1100 (AEDT)
Subject: Re: [PATCH RESEND v10 00/10] Application Data Integrity feature
 introduced by SPARC M7
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <cover.1510768775.git.khalid.aziz@oracle.com>
Date: Thu, 16 Nov 2017 18:14:37 -0800
Cc: David Miller <davem@davemloft.net>, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, 0x7f454c46@gmail.com, aarcange@redhat.com,
 ak@linux.intel.com, Allen Pais <allen.pais@oracle.com>,
 aneesh.kumar@linux.vnet.ibm.com, arnd@arndb.de,
 Atish Patra <atish.patra@oracle.com>, benh@kernel.crashing.org,
 Bob Picco <bob.picco@oracle.com>, bsingharora@gmail.com,
 chris.hyser@oracle.com, cmetcalf@mellanox.com, corbet@lwn.net,
 dan.carpenter@oracle.com, dave.jiang@intel.com, dja@axtens.net,
 Eric Saint Etienne <eric.saint.etienne@oracle.com>,
 geert@linux-m68k.org, hannes@cmpxchg.org, heiko.carstens@de.ibm.com,
 hpa@zytor.com, hughd@google.com, imbrenda@linux.vnet.ibm.com,
 jack@suse.cz, jmarchan@redhat.com, jroedel@suse.de,
 Khalid Aziz <khalid@gonehiking.org>, kirill.shutemov@linux.intel.com,
 Liam.Howlett@oracle.com, lstoakes@gmail.com, mgorman@suse.de,
 mhocko@suse.com, Mike Kravetz <mike.kravetz@oracle.com>,
 minchan@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
 nitin.m.gupta@oracle.com, pasha.tatashin@oracle.com,
 paul.gortmaker@windriver.com, paulus@samba.org, peterz@infradead.org,
 rientjes@google.com, ross.zwisler@linux.intel.com, shli@fb.com,
 steven.sistare@oracle.com, tglx@linutronix.de, thomas.tai@oracle.com,
 tklauser@distanz.ch, tom.hromatka@oracle.com, vegard.nossum@oracle.com,
 vijay.ac.kumar@oracle.com, viro@zeniv.linux.org.uk,
 willy@infradead.org, x86@kernel.org, ying.huang@intel.com,
 zhongjiang@huawei.com, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Message-Id: <3D32E16F-281B-464B-8F6D-D6A8FE62FAB2@oracle.com>
References: <cover.1510768775.git.khalid.aziz@oracle.com>
To: Khalid Aziz <khalid.aziz@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On Nov 16, 2017, at 6:38 AM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
> Changelog v10:
> 
> 	- Patch 1/10: Updated si_codes definitions for SEGV to match 4.14
> 	- Patch 2/10: No changes
> 	- Patch 3/10: Updated copyright
> 	- Patch 4/10: No changes
> 	- Patch 5/10: No changes
> 	- Patch 6/10: Updated copyright
> 	- Patch 7/10: No changes
> 	- Patch 8/10: No changes
> 	- Patch 9/10: No changes
> 	- Patch 10/10: Added code to return from kernel path to set
> 	  PSTATE.mcde if kernel continues execution in another thread
> 	  (Suggested by Anthony)

Looks good, Khalid.  Thanks for making the changes.

For the entire series:

Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
