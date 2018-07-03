Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KV5t45X7zF1QS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 13:31:30 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id c9-v6so284428pgf.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 20:31:30 -0700 (PDT)
Date: Tue, 3 Jul 2018 13:31:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, stewart@linux.vnet.ibm.com,
 benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH v2 2/2] powernv/cpuidle: Use parsed device tree values
 for cpuidle_init
Message-ID: <20180703133122.245109d0@roar.ozlabs.ibm.com>
In-Reply-To: <1530541401-19726-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1530541401-19726-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1530541401-19726-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
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

On Mon,  2 Jul 2018 19:53:21 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> Export pnv_idle_states and nr_pnv_idle_states so that its accessible to
> cpuidle driver. Use properties from pnv_idle_states structure for powernv
> cpuidle_init.
>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
