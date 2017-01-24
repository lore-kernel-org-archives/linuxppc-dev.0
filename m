Return-Path: <tony.luck@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7Glh4sZLzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 05:23:44 +1100 (AEDT)
Received: by mail-ua0-x243.google.com with SMTP id f2so17124610uaf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 10:23:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <20170106020324.GB2863@dhcp-128-65.nay.redhat.com>
 <38a7807c-cd95-670d-30d3-c45e7921ea11@linux.vnet.ibm.com>
 <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
From: Tony Luck <tony.luck@gmail.com>
Date: Tue, 24 Jan 2017 10:23:41 -0800
Message-ID: <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] ia64: reuse append_elf_note() and final_note()
 functions
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Dave Young <dyoung@redhat.com>, kexec-ml <kexec@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 24, 2017 at 10:11 AM, Hari Bathini
<hbathini@linux.vnet.ibm.com> wrote:

> Hello IA64 folks,
>
> Could you please review this patch..?

It looks OK in principal.  My lab is in partial disarray at the
moment (just got back from a sabbatical) so I can't test
build and boot. Have you cross-compiled it (or gotten a success
build report from zero-day)?

If you have ... then add an Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
