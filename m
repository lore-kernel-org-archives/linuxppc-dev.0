Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qljSn1gYpzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 11:17:13 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id ot11so39600953pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 18:17:13 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] perf probe fixes for ppc64le
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1460451721.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: Mark Wielaard <mjw@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <570EEF89.5080107@gmail.com>
Date: Thu, 14 Apr 2016 11:16:57 +1000
MIME-Version: 1.0
In-Reply-To: <cover.1460451721.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/04/16 19:10, Naveen N. Rao wrote:
> This patchset fixes three issues found with perf probe on ppc64le:
> 1. 'perf test kallsyms' failure on ppc64le (reported by Michael
> Ellerman). This was due to the symbols being fixed up during symbol
> table load. This is fixed in patch 2 by delaying symbol fixup until
> later.
> 2. perf probe function offset was being calculated from the local entry
> point (LEP), which does not match user expectation when trying to look
> at function disassembly output (reported by Ananth N). This is fixed for
> kallsyms in patch 1 and for symbol table in patch 2.
> 3. perf probe failure with kretprobe when using kallsyms. This was
> failing as we were specifying an offset. This is fixed in patch 1.
> 
> A few examples demonstrating the issues and the fix:
> 

Given the choices, I think this makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
