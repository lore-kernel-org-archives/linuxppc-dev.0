Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 34C642C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 09:07:09 +1100 (EST)
Message-ID: <1363212419.3155.57.camel@smoke>
Subject: Re: [PATCH -V4 2/3] powerpc: Update kernel VSID range
From: Geoff Levand <geoff@infradead.org>
To: benh@kernel.crashing.org
Date: Wed, 13 Mar 2013 15:06:59 -0700
In-Reply-To: <1363181695-5315-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1363181695-5315-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1363181695-5315-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, 2013-03-13 at 19:04 +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This patch change the kernel VSID range so that we limit VSID_BITS to 37.
> This enables us to support 64TB with 65 bit VA (37+28). Without this patch
> we have boot hangs on platforms that only support 65 bit VA.

I tested the V4 series on PS3 applied to linux-3.8 and it fixed the boot
hang problem.

Ben, please apply.

Tested-by: Geoff Levand <geoff@infradead.org>
