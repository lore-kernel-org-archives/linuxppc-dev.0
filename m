Return-Path: <tony.luck@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCghr1lXwzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 09:21:32 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id u63so1348994wmu.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 14:21:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <04b96f50-f77d-9446-975f-7d44accfe583@linux.vnet.ibm.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <20170106020324.GB2863@dhcp-128-65.nay.redhat.com>
 <38a7807c-cd95-670d-30d3-c45e7921ea11@linux.vnet.ibm.com>
 <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
 <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
 <04b96f50-f77d-9446-975f-7d44accfe583@linux.vnet.ibm.com>
From: Tony Luck <tony.luck@gmail.com>
Date: Tue, 31 Jan 2017 14:21:27 -0800
Message-ID: <CA+8MBbLP5TvmbDgbg6cvUCV+0hhXdYi546Rs-fEAoQjcotNXvw@mail.gmail.com>
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

On Wed, Jan 25, 2017 at 11:15 AM, Hari Bathini
<hbathini@linux.vnet.ibm.com> wrote:
> I haven't gotten a success/failure build report from zero-day. Not sure what
> to make of it.

zero-day is generally silent unless it sees a problem. So no news is good news.

> But I did try cross-compiling and it was successful. Should that do?

I guess so. What tree do these apply to?  I tried 4.10-rc5 and "git am"
protested ... but I didn't look closely as at why.

-Tony
