Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ACA11A05A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 03:19:45 +1100 (AEDT)
Date: Mon, 9 Mar 2015 16:19:12 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 0/10] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150309161912.GW8656@n2100.arm.linux.org.uk>
References: <1425435025-30284-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425435025-30284-1-git-send-email-keescook@chromium.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Andrey Ryabinin <a.ryabinin@samsung.com>,
 Behan Webster <behanw@converseincode.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Ben Hutchings <ben@decadent.org.uk>, Will Deacon <will.deacon@arm.com>,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Dan McGee <dpmcgee@gmail.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 03, 2015 at 06:10:15PM -0800, Kees Cook wrote:
> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442
> 
> I've been able to test x86 and arm, and the buildbot (so far) seems
> happy with building the rest.

Hmm, do you want to wrap my acks up to your previous one into this set?
What about my tested-by?

I'd rather not waste time testing this version if my previous test is
still valid (or if there's yet another version of this patch set which
is later than this set.)

Unless I hear anything, I'll assume that it's broadly the same as the
previous patch set and requires no action.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
