Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjqc564KszDrSv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 15:47:33 +1000 (AEST)
Date: Tue, 27 Sep 2016 15:46:07 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 LINUX FOR POWERPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] Remove duplicate setting of the B field in tlbie
Message-ID: <20160927054607.f7g6vgkupkjuymim@oak.ozlabs.ibm.com>
References: <f706a4d0-40d5-2eaa-67d9-8fb02475ca4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f706a4d0-40d5-2eaa-67d9-8fb02475ca4d@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 16, 2016 at 05:25:50PM +1000, Balbir Singh wrote:
> 
> Remove duplicate setting of the the "B" field when doing a tlbie(l).
> In compute_tlbie_rb(), the "B" field is set again just before
> returning the rb value to be used for tlbie(l).
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Thanks, applied to kvm-ppc-next.

Paul.
