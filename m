Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkTqY04VvzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 05:30:48 +1000 (AEST)
Message-ID: <59A9B1D5.7030307@iogearbox.net>
Date: Fri, 01 Sep 2017 21:15:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, mpe@ellerman.id.au
CC: naveen.n.rao@linux.vnet.ibm.com, ast@fb.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] bpf: take advantage of stack_depth tracking in powerpc
 JIT
References: <20170901185301.17978-1-sandipan@linux.vnet.ibm.com>
In-Reply-To: <20170901185301.17978-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2017 08:53 PM, Sandipan Das wrote:
> Take advantage of stack_depth tracking, originally introduced for
> x64, in powerpc JIT as well. Round up allocated stack by 16 bytes
> to make sure it stays aligned for functions called from JITed bpf
> program.
>
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>

Awesome, thanks for following up! :)
