Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BE8E1A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 15:40:06 +1000 (AEST)
Date: Mon, 15 Jun 2015 15:37:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, scottwood@freescale.com,
 warrier@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com, mingo@kernel.org
Subject: Re: [PATCH RESEND v4 3/3] kvm/powerpc: Export HCALL reason codes
Message-ID: <20150615053720.GA15637@pale.ozlabs.ibm.com>
References: <1434344169-32438-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1434344169-32438-3-git-send-email-hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434344169-32438-3-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 15, 2015 at 10:26:09AM +0530, Hemant Kumar wrote:
> For perf to analyze the KVM events like hcalls, we need the
> hypervisor calls and their codes to be exported through uapi.

Why?  The hcall codes are defined externally to the kernel (in the
PAPR document) and won't change.  They're not kernel API.

Paul.
