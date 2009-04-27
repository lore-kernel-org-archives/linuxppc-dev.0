Return-Path: <pku.leo@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 7C925DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 17:48:24 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so1283402anc.39
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 00:48:21 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090424183517.GB23140@ovro.caltech.edu>
References: <20090424183517.GB23140@ovro.caltech.edu>
Date: Mon, 27 Apr 2009 15:48:21 +0800
Message-ID: <2a27d3730904270048g1e247797s6a25f9e28d664214@mail.gmail.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
From: Li Yang <leoli@freescale.com>
To: Ira Snyder <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 25, 2009 at 2:35 AM, Ira Snyder <iws@ovro.caltech.edu> wrote:
> By default, the Freescale 83xx DMA controller uses the PCI Read Line
> command when reading data over the PCI bus. Setting the controller to use
> the PCI Read Multiple command instead allows the controller to read much
> larger bursts of data, which provides a drastic speed increase.
>
> The slowdown due to using PCI Read Line was only observed when a PCI-to-PCI
> bridge was between the devices trying to communicate.
>
> A simple test driver showed an increase from 4MB/sec to 116MB/sec when
> performing DMA over the PCI bus. Using DMA to transfer between blocks of
> local SDRAM showed no change in performance with this patch. The dmatest
> driver was also used to verify the correctness of the transfers, and showed
> no errors.
>
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Acked-by: Li Yang <leoli@freescale.com>

Thanks,
Leo
