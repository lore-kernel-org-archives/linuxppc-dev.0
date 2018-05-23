Return-Path: <jakub.kicinski@netronome.com>
Received: from mail-qt0-x22b.google.com (mail-qt0-x22b.google.com
 [IPv6:2607:f8b0:400d:c0d::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rm2W1K1BzF1BS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 07:32:51 +1000 (AEST)
Received: by mail-qt0-x22b.google.com with SMTP id f13-v6so30106553qtp.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:32:50 -0700 (PDT)
Date: Wed, 23 May 2018 14:32:44 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, Quentin Monnet
 <quentin.monnet@netronome.com>
Subject: Re: [PATCH bpf-next v3 10/10] tools: bpftool: add delimiters to
 multi-function JITed dumps
Message-ID: <20180523143244.52db840f@cakuba>
In-Reply-To: <7142939b-515e-50ac-bc0b-50444bf9cc97@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
 <88b61b11ebca5b44bad0c34225b6f2383e5983a5.1527008647.git.sandipan@linux.vnet.ibm.com>
 <20180522125544.541c68c8@cakuba>
 <2dabfa7f-15b8-236c-7724-33bc3da7e549@iogearbox.net>
 <7142939b-515e-50ac-bc0b-50444bf9cc97@linux.vnet.ibm.com>
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

On Wed, 23 May 2018 16:07:40 +0530, Sandipan Das wrote:
>         "name": "bpf_prog_196af774a3477707_F",
>         "insns": [{
>                 "pc": "0x0",
>                 "operation": "nop",
>                 "operands": [null
>                 ]
>             },{
>                 "pc": "0x4",
>                 "operation": "nop",
>                 "operands": [null
>                 ]
>             },{
>                 "pc": "0x8",
>                 "operation": "mflr",
>                 "operands": ["r0"
>                 ]
>             },{
>                 ...
>             }
>         ]
>     }
> ]
> 
> If this is okay, I can send out the next revision with these changes.

Looks good, thank you!
