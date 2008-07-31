Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19554DE016
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 01:30:14 +1000 (EST)
Date: Thu, 31 Jul 2008 17:29:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/5] x86: Define elfcorehdr_addr in arch dependent section
Message-ID: <20080731152926.GA20909@elte.hu>
References: <20080727234529.GM6175@verge.net.au>
	<20080728015117.GA12055@verge.net.au>
	<20080728024526.GB3334@verge.net.au>
	<20080728034007.GA30450@verge.net.au>
	<20080728211025.GA9985@redhat.com>
	<20080728211156.GB9985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080728211156.GB9985@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Terry Loftin <terry.loftin@hp.com>, Simon Horman <horms@verge.net.au>,
	Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Vivek Goyal <vgoyal@redhat.com> wrote:

> o Move elfcorehdr_addr definition in arch dependent crash dump file. This is
>   equivalent to defining elfcorehdr_addr under CONFIG_CRASH_DUMP instead of
>   CONFIG_PROC_VMCORE. This is needed by is_kdump_kernel() which can be
>   used irrespective of the fact whether CONFIG_PROC_VMCORE is enabled or
>   not.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
> 
>  arch/x86/kernel/crash_dump_32.c |    3 +++
>  arch/x86/kernel/crash_dump_64.c |    3 +++
>  arch/x86/kernel/setup.c         |    8 +++++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)

the x86 bits look fine to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
