Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 960ACB6F9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 07:15:51 +1000 (EST)
Date: Mon, 06 Jun 2011 13:17:18 -0700 (PDT)
Message-Id: <20110606.131718.2215062170051315214.davem@davemloft.net>
To: eparis@redhat.com
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
	ptrace.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, heiko.carstens@de.ibm.com,
	oleg@redhat.com, paulus@samba.org, hpa@zytor.com,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	richard@nod.at, x86@kernel.org, mingo@redhat.com, fenghua.yu@intel.com,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, jdike@addtoit.com,
	viro@zeniv.linux.org.uk, tglx@linutronix.de, monstr@monstr.eu,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org, schwidefsky@de.ibm.com,
	linux390@de.ibm.com, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Paris <eparis@redhat.com>
Date: Fri, 03 Jun 2011 18:04:51 -0400

 ...
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Acked-by: H. Peter Anvin <hpa@zytor.com> [for x86 portion]

For sparc parts:

Acked-by: David S. Miller <davem@davemloft.net>
