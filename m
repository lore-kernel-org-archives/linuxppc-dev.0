Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0YdG1pYrzDqcp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 07:09:54 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 127so9647728pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 12:09:54 -0800 (PST)
Date: Fri, 13 Jan 2017 12:09:47 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net,
 davem@davemloft.net
Subject: Re: [PATCH 1/3] powerpc: bpf: remove redundant check for non-null
 image
Message-ID: <20170113200945.GA60330@ast-mbp.thefacebook.com>
References: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 13, 2017 at 10:40:00PM +0530, Naveen N. Rao wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> 
> We have a check earlier to ensure we don't proceed if image is NULL. As
> such, the redundant check can be removed.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> [Added similar changes for classic BPF JIT]
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Alexei Starovoitov <ast@kernel.org>
