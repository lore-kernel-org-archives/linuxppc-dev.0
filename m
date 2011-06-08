Return-Path: <ralf@linux-mips.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 049B8B6FD4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 00:05:15 +1000 (EST)
Date: Wed, 8 Jun 2011 15:04:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
	ptrace.h
Message-ID: <20110608140416.GA19926@linux-mips.org>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, heiko.carstens@de.ibm.com,
	oleg@redhat.com, paulus@samba.org, hpa@zytor.com,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	richard@nod.at, x86@kernel.org, mingo@redhat.com, fenghua.yu@intel.com,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, jdike@addtoit.com,
	viro@zeniv.linux.org.uk, tglx@linutronix.de, monstr@monstr.eu,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
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

On Fri, Jun 03, 2011 at 06:04:51PM -0400, Eric Paris wrote:

Thanks, this looks good & compiles, so:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

I will rebase my pending MIPS audit patches on top of this patch and resend.

Thanks,

  Ralf
