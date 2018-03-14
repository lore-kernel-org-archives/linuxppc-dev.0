Return-Path: <dave.hansen@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401YVG3lvMzDr2G
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 01:08:33 +1100 (AEDT)
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
To: Florian Weimer <fweimer@redhat.com>, Ram Pai <linuxram@us.ibm.com>
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <ec90ed75-2810-bcc3-8439-8dc85a6b46ac@redhat.com>
 <20180309200017.GR1060@ram.oc3035372033.ibm.com>
 <f71b583f-2b66-e9ed-b08b-fddff228a5a7@redhat.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 corbet@lwn.net, arnd@arndb.de, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b525f67d-8b79-56c1-2eed-292a806d9202@intel.com>
Date: Wed, 14 Mar 2018 07:08:29 -0700
MIME-Version: 1.0
In-Reply-To: <f71b583f-2b66-e9ed-b08b-fddff228a5a7@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2018 01:00 AM, Florian Weimer wrote:
> ... but not the key which is used for PROT_EXEC emulation, which is still
> reserved

The PROT_EXEC key is dynamically allocated.  There is no "the key".
