Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Pvv86ZmNzDrTn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 18:07:32 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id y5-v6so1843874pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 01:07:32 -0700 (PDT)
Date: Tue, 10 Jul 2018 18:07:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: vrbagal1 <vrbagal1@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-fsdevel@vger.kernel.org, sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [powerpc/powervm]Oops: Kernel access of bad area, sig: 11 [#1]
 while running stress-ng
Message-ID: <20180710180708.6e0cd26b@roar.ozlabs.ibm.com>
In-Reply-To: <8595a4f915a7344210a8cc7ad6923a2b@linux.vnet.ibm.com>
References: <8595a4f915a7344210a8cc7ad6923a2b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Jul 2018 11:58:40 +0530
vrbagal1 <vrbagal1@linux.vnet.ibm.com> wrote:

> Hi,
> 
> Observing kernel oops on Power9(ZZ) box, running on PowerVM, while 
> running stress-ng.
> 
> 
> Kernel: 4.18.0-rc4
> Machine: Power9 ZZ (PowerVM)
> Test: Stress-ng
> 
> Attached is .config file
> 
> Traces:
> 
>   [12251.245209] Oops: Kernel access of bad area, sig: 11 [#1]

Can you post the lines above this? Otherwise we don't know what address
it tried to access (without decoding the instructions and reconstructing
it from registers at least, which the XFS devs wouldn't be inclined to
do).

And I assume there is nothing else relevant to XFS in the dmesg before
this?

Thanks,
Nick
