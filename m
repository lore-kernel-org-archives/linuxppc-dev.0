Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 32E4B2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 10:06:42 +1100 (EST)
Date: Thu, 13 Feb 2014 15:06:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 0/3]  powerpc: Fix random application crashes with
 NUMA_BALANCING enabled
Message-Id: <20140213150639.2b9124797ac4975b6119f6f0@linux-foundation.org>
In-Reply-To: <1392176618-23667-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1392176618-23667-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: riel@redhat.com, linux-mm@kvack.org, paulus@samba.org, mgorman@suse.de,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Feb 2014 09:13:35 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Hello,
> 
> This patch series fix random application crashes observed on ppc64 with numa
> balancing enabled. Without the patch we see crashes like
> 
> anacron[14551]: unhandled signal 11 at 0000000000000041 nip 000000003cfd54b4 lr 000000003cfd5464 code 30001
> anacron[14599]: unhandled signal 11 at 0000000000000041 nip 000000003efc54b4 lr 000000003efc5464 code 30001
> 

Random application crashes are bad.  Which kernel version(s) do you think
need fixing here?

I grabbed the patches but would like to hear from Ben (or something
approximating him) before doing anything with them, please.
