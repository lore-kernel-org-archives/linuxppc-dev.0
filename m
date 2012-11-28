Return-Path: <jwboyer@gmail.com>
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com
 [209.85.220.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A45022C0091
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2012 07:27:05 +1100 (EST)
Received: by mail-vc0-f170.google.com with SMTP id fl11so10506137vcb.15
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2012 12:27:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353716453-9693-1-git-send-email-acme@infradead.org>
References: <1353716453-9693-1-git-send-email-acme@infradead.org>
Date: Wed, 28 Nov 2012 15:27:02 -0500
Message-ID: <CA+5PVA4dMd8ZfN6OgDQXvFxSPSN3+Cim27ZypWni3ihErSE7tQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/8] perf/urgent fixes
From: Josh Boyer <jwboyer@gmail.com>
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
 David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Robert Richter <robert.richter@amd.com>, Namhyung Kim <namhyung@gmail.com>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linuxppc-dev@ozlabs.org,
 Dong Hao <haodong@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 David Ahern <dsahern@gmail.com>, Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, x86@kernel.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 23, 2012 at 7:20 PM, Arnaldo Carvalho de Melo
<acme@ghostprotocols.net> wrote:
> Hi Ingo,
>
>         Tested using a cross-compiler and directly on a Raspberry pi (ARM) with
> raspbian.
>
>         Please consider pulling.
>
> - Arnaldo
>
> The following changes since commit 18423d3562f396206e0928a71177eeb2edfed077:
>
>   Merge tag 'perf-urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2012-11-13 18:51:51 +0100)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-urgent-for-mingo
>
> for you to fetch changes up to 7321090f6751c9987c26a8c81c63680d16a614d7:
>
>   perf kvm: Fix building perf kvm on non x86 arches (2012-11-23 20:40:17 -0300)
>
> ----------------------------------------------------------------
> perf/urgent fixes
>
> . Don't build 'perf kvm stat" on non-x86 arches, fix from Xiao Guangrong.
>
> . UAPI fixes to get perf building again in non-x86 arches, from David Howells.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       Merge tag 'perf-uapi-20121119' of git://git.infradead.org/users/dhowells/linux-headers into perf/urgent
>
> David Howells (6):
>       x86: Export asm/{svm.h,vmx.h,perf_regs.h}
>       Merge branch 'x86-pre-uapi' into perf-uapi
>       tools: Define a Makefile function to do subdir processing
>       tools: Honour the O= flag when tool build called from a higher Makefile
>       tools: Pass the target in descend
>       perf: Make perf build for x86 with UAPI disintegration applied
>
> Sukadev Bhattiprolu (1):
>       perf powerpc: Use uapi/unistd.h to fix build error
>
> Xiao Guangrong (2):
>       perf kvm: Rename perf_kvm to perf_kvm_stat
>       perf kvm: Fix building perf kvm on non x86 arches

I probably sound like a broken record at this point, but I've not seen
this go into any tip branch, nor is it in Linus' tree.  Hopefully this
gets pulled before 3.7 is released.

josh
