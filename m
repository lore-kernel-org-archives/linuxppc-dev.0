Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sh1zp6d6CzDrVL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 17:28:22 +1000 (AEST)
Received: by mail-pf0-f195.google.com with SMTP id 6so6250443pfl.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 00:28:22 -0700 (PDT)
Date: Sat, 24 Sep 2016 03:27:18 -0400
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Alexei Starovoitov <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 2/2] bpf samples: update tracex5 sample to use
 __seccomp_filter
Message-ID: <20160924072716.GA48071@ast-mbp.thefacebook.com>
References: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
 <8e5ab9853508240e901260b1af36243c4d744083.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8e5ab9853508240e901260b1af36243c4d744083.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 24, 2016 at 02:10:05AM +0530, Naveen N. Rao wrote:
> seccomp_phase1() does not exist anymore. Instead, update sample to use
> __seccomp_filter(). While at it, set max locked memory to unlimited.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Alexei Starovoitov <ast@kernel.org>
