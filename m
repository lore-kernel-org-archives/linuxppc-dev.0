Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBqk0nCLzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:58:40 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id y206so594246wmd.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 05:58:40 -0700 (PDT)
Date: Thu, 27 Jul 2017 15:58:35 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/3] powerpc/mm: update pmdp_invalidate to return old
 pmd value
Message-ID: <20170727125835.4vtk25cttgs5awk2@node.shutemov.name>
References: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727125449.GB27766@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170727125449.GB27766@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 27, 2017 at 02:54:49PM +0200, Michal Hocko wrote:
> EMISSING_CHANGELOG
> 
> besides that no user actually uses the return value. Please fold this
> into the patch which uses the new functionality.

That's for patchset I'm working on[1].

[1] http://lkml.kernel.org/r/20170615145224.66200-1-kirill.shutemov@linux.intel.com

-- 
 Kirill A. Shutemov
