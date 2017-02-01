Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vClSz4LnwzDqb7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:11:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tony Luck <tony.luck@gmail.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: "Yu\, Fenghua" <fenghua.yu@intel.com>,
 "linux-ia64\@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Dave Young <dyoung@redhat.com>, kexec-ml <kexec@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@lists.ozlabs.org,
 "vgoyal\@redhat.com" <vgoyal@redhat.com>
Subject: Re: [PATCH v4 2/5] ia64: reuse append_elf_note() and final_note()
 functions
In-Reply-To: <CA+8MBbLP5TvmbDgbg6cvUCV+0hhXdYi546Rs-fEAoQjcotNXvw@mail.gmail.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <20170106020324.GB2863@dhcp-128-65.nay.redhat.com>
 <38a7807c-cd95-670d-30d3-c45e7921ea11@linux.vnet.ibm.com>
 <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
 <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
 <04b96f50-f77d-9446-975f-7d44accfe583@linux.vnet.ibm.com>
 <CA+8MBbLP5TvmbDgbg6cvUCV+0hhXdYi546Rs-fEAoQjcotNXvw@mail.gmail.com>
Date: Wed, 01 Feb 2017 12:11:28 +1100
Message-ID: <874m0evhof.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tony Luck <tony.luck@gmail.com> writes:

> On Wed, Jan 25, 2017 at 11:15 AM, Hari Bathini
> <hbathini@linux.vnet.ibm.com> wrote:
>> I haven't gotten a success/failure build report from zero-day. Not sure what
>> to make of it.
>
> zero-day is generally silent unless it sees a problem. So no news is good news.
>
>> But I did try cross-compiling and it was successful. Should that do?
>
> I guess so. What tree do these apply to?  I tried 4.10-rc5 and "git am"
> protested ... but I didn't look closely as at why.

Don't worry about it, I do an ia64_defconfig build as part of my usual
tests before pushing.

cheers
