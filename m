Return-Path: <dave.hansen@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWl1H5jkMzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 09:47:14 +1100 (AEDT)
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
To: Ram Pai <linuxram@us.ibm.com>, Florian Weimer <fw@deneb.enyo.de>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
 <20171107012218.GA5546@ram.oc3035372033.ibm.com>
 <87h8u6lf27.fsf@mid.deneb.enyo.de>
 <20171107223953.GB5546@ram.oc3035372033.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org,
 ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <8b970e5b-50e6-bcc1-e8d3-6e3aa8523f55@intel.com>
Date: Tue, 7 Nov 2017 14:47:10 -0800
MIME-Version: 1.0
In-Reply-To: <20171107223953.GB5546@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2017 02:39 PM, Ram Pai wrote:
> 
> As per the current semantics of sys_pkey_free(); the way I understand it,
> the calling thread is saying disassociate me from this key.

No.  It is saying: "this *process* no longer has any uses of this key,
it can be reused".
