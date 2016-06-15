Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVKRd15CgzDqlJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 07:30:04 +1000 (AEST)
Date: Wed, 15 Jun 2016 18:29:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Borislav Petkov <bp@suse.de>, David Ahern <dsahern@gmail.com>,
 George Spelvin <linux@horizon.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Wang Nan <wangnan0@huawei.com>, Yury Norov <yury.norov@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] tools/perf: fix the word selected in find_*_bit
Message-ID: <20160615212958.GC4882@kernel.org>
References: <1465990973-31483-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160615195127.GA6039@yury-N73SV>
 <20160615211104.GA6978@yury-N73SV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160615211104.GA6978@yury-N73SV>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Jun 16, 2016 at 12:11:04AM +0300, Yury Norov escreveu:
> On Wed, Jun 15, 2016 at 10:51:27PM +0300, Yury Norov wrote:
> > Maybe there already is some macro doing the conversion for you...
> 
> yes it is, cpu_to_le64() is what you want

Beware that the cpu_to_le64() in tools/perf is bogus, we need to grab a
copy from the kernel sources.

- Arnaldo
