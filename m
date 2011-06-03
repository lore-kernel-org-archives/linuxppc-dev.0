Return-Path: <tony.luck@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB463B6FB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 08:52:13 +1000 (EST)
Received: by iwc10 with SMTP id 10so2375332iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 03 Jun 2011 15:52:10 -0700 (PDT)
MIME-Version: 1.0
Sender: tony.luck@gmail.com
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
Date: Fri, 3 Jun 2011 15:52:09 -0700
Message-ID: <BANLkTik4qRe--C6L5WU3XvpP-TMEZ6RQ-w@mail.gmail.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
	ptrace.h
From: Tony Luck <tony.luck@intel.com>
To: Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, heiko.carstens@de.ibm.com,
	oleg@redhat.com, paulus@samba.org, hpa@zytor.com,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	richard@nod.at, x86@kernel.org, mingo@redhat.com, fenghua.yu@intel.com,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, jdike@addtoit.com,
	viro@zeniv.linux.org.uk, tglx@linutronix.de, monstr@monstr.eu,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 3, 2011 at 3:04 PM, Eric Paris <eparis@redhat.com> wrote:
> The other major change is that on some arches, like ia64, we change
> regs_return_value() to give us the negative value on syscall failure. =A0=
The
> only other user of this macro, kretprobe_example.c, won't notice and it m=
akes
> the value signed consistently for the audit functions across all archs.

v2 builds and boots on ia64 now
Acked-by: Tony Luck <tony.luck@intel.com>


> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Acked-by: H. Peter Anvin <hpa@zytor.com> [for x86 portion]

  ^^^^^^^^^^^^^^^^^^^^  :-)

-Tony
