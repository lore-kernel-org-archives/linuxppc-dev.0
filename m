Return-Path: <khalid.aziz@oracle.com>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404frN0fR1zF1jJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 02:20:03 +1100 (AEDT)
Subject: Re: [PATCH v12 00/11] Application Data Integrity feature introduced
 by SPARC M7
To: David Miller <davem@davemloft.net>
Cc: dave.hansen@linux.intel.com, aarcange@redhat.com,
 akpm@linux-foundation.org, allen.pais@oracle.com,
 aneesh.kumar@linux.vnet.ibm.com, anthony.yznaga@oracle.com,
 arnd@arndb.de, benh@kernel.crashing.org, bob.picco@oracle.com,
 bsingharora@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
 dave.jiang@intel.com, david.j.aldridge@oracle.com, dwindsor@gmail.com,
 ebiederm@xmission.com, elena.reshetova@intel.com,
 gregkh@linuxfoundation.org, hannes@cmpxchg.org,
 henry.willard@oracle.com, hpa@zytor.com, hughd@google.com,
 imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com,
 jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de,
 khalid@gonehiking.org, khandual@linux.vnet.ibm.com,
 kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org,
 ktkhai@virtuozzo.com, liam.merwick@oracle.com,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com, linux@roeck-us.net,
 me@tobin.cc, mgorman@suse.de, mgorman@techsingularity.net,
 mhocko@suse.com, mike.kravetz@oracle.com, minchan@kernel.org,
 mingo@kernel.org
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <20180318.110857.1660518649370410007.davem@davemloft.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <b9507686-6c3f-7fb1-b305-c1817f86a884@oracle.com>
Date: Mon, 19 Mar 2018 09:19:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180318.110857.1660518649370410007.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/18/2018 09:08 AM, David Miller wrote:
> In uapi/asm/auxvec.h you conditionalize the ADI aux vectors on
> CONFIG_SPARC64.
> 
> That's not correct, you should never control user facing definitions
> based upon kernel configuration.
> 
> Also, both 32-bit and 64-bit applications running on ADI capable
> machines want to compile against and use this informaiton.
> 
> So please remove these CPP checks.
> 

Hi Dave,

That makes sense. I will send a patch to remove these.

Thanks,
Khalid
