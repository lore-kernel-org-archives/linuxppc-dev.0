Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0DB3A2C01D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 09:31:15 +1000 (EST)
Message-ID: <1370475066.3766.249.camel@pasglop>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 06 Jun 2013 09:31:06 +1000
In-Reply-To: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 20:58 +0530, Aneesh Kumar K.V wrote:
> 
> This is the second patchset needed to support THP on ppc64. Some of the changes
> included in this series are tricky in that it changes the powerpc linux page table
> walk subtly. We also overload few of the pte flags for ptes at PMD level (huge
> page PTEs).
> 
> The related mm/ changes are already merged to Andrew's -mm tree.

If I am to put that into powerpc-next, I need the dependent mm/ changes as well.

Do you have them in the form of a separate git tree that is *exactly* (same SHA1s)
what is expected to go upstream via Andrew ?

Andrew, are they fully acked on your side and ready to go ?

Cheers,
Ben.
