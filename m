Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AD521A0108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 12:50:45 +1100 (AEDT)
Message-ID: <1416275444.1107.4.camel@concordia>
Subject: Re: [PATCH net-next] PPC: bpf_jit_comp: Unify BPF_MOD | BPF_X and
 BPF_DIV | BPF_X
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Date: Tue, 18 Nov 2014 12:50:44 +1100
In-Reply-To: <1416254861-3879-1-git-send-email-kda@linux-powerpc.org>
References: <1416254861-3879-1-git-send-email-kda@linux-powerpc.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Daniel Borkmann <dborkman@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-17 at 23:07 +0300, Denis Kirjanov wrote:
> Reduce duplicated code by unifying
> BPF_ALU | BPF_MOD | BPF_X and BPF_ALU | BPF_DIV | BPF_X
> 
> CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
> CC: Daniel Borkmann<dborkman@redhat.com>
> CC: Philippe Bergheaud<felix@linux.vnet.ibm.com>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Please include the output of the test suite.

Assuming that's OK I'm happy for it to go in.

cheers
