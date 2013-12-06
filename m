Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 0B2732C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 19:37:43 +1100 (EST)
Date: Fri, 6 Dec 2013 09:39:34 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 00/11] Introduce pcim_enable_msi*() family helpers
Message-ID: <20131206083934.GA17949@dhcp-26-207.brq.redhat.com>
References: <cover.1385399393.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1385399393.git.agordeev@redhat.com>
Cc: Mark Lord <kernel@start.ca>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Ellerman <michael@ellerman.id.au>,
 Ben Hutchings <bhutchings@solarflare.com>,
 David Laight <David.Laight@ACULAB.COM>, "H. Peter Anvin" <hpa@zytor.com>,
 Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 26, 2013 at 10:09:49AM +0100, Alexander Gordeev wrote:
> Patches 3,4	- fixes for PowerPC pSeries platform
[...]
>   PCI/MSI/pSeries: Fix wrong error code reporting
>   PCI/MSI/pSeries: Make quota traversing and requesting race-safe

Hi Bjorn,

The two unreviewed PowerPC patches is not a blocker for the rest of the
series as they are completely independent with the rest of the changes.
I can rework them later if needed.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
