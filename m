Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdzPL6Np9zDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 03:24:22 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id 184so48635017pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Apr 2016 10:24:22 -0700 (PDT)
Date: Mon, 4 Apr 2016 10:24:16 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
 "David S . Miller" <davem@davemloft.net>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCHv2 net 2/3] samples/bpf: Use llc in PATH, rather than a
 hardcoded value
Message-ID: <20160404172414.GA67762@ast-mbp.thefacebook.com>
References: <5ab5eec91d2d0bc7f221d714ef84afac83b2604b.1459789086.git.naveen.n.rao@linux.vnet.ibm.com>
 <000e23c21f475e7106c74a83eb6226c4cb8d4a14.1459789086.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000e23c21f475e7106c74a83eb6226c4cb8d4a14.1459789086.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 04, 2016 at 10:31:33PM +0530, Naveen N. Rao wrote:
> While at it, remove the generation of .s files and fix some typos in the
> related comment.
> 
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Alexei Starovoitov <ast@kernel.org>
