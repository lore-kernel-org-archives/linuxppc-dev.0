Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F2B492C0078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 16:42:08 +1100 (EST)
Message-ID: <1392356501.3835.217.camel@pasglop>
Subject: Re: [PATCH V2 0/3]  powerpc: Fix random application crashes with
 NUMA_BALANCING enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 14 Feb 2014 16:41:41 +1100
In-Reply-To: <20140213150639.2b9124797ac4975b6119f6f0@linux-foundation.org>
References: <1392176618-23667-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140213150639.2b9124797ac4975b6119f6f0@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: riel@redhat.com, linux-mm@kvack.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mgorman@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-02-13 at 15:06 -0800, Andrew Morton wrote:
> On Wed, 12 Feb 2014 09:13:35 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
> > Hello,
> > 
> > This patch series fix random application crashes observed on ppc64 with numa
> > balancing enabled. Without the patch we see crashes like
> > 
> > anacron[14551]: unhandled signal 11 at 0000000000000041 nip 000000003cfd54b4 lr 000000003cfd5464 code 30001
> > anacron[14599]: unhandled signal 11 at 0000000000000041 nip 000000003efc54b4 lr 000000003efc5464 code 30001
> > 
> 
> Random application crashes are bad.  Which kernel version(s) do you think
> need fixing here?
> 
> I grabbed the patches but would like to hear from Ben (or something
> approximating him) before doing anything with them, please.

Ah good. Did you grab v2 ? v1 had a compile breakage. I was about to
send them to Linus today as well but then got distracted by a sick
child, so I'm happy for you to pick them up and send them to the
boss :-)

Cheers,
Ben.
