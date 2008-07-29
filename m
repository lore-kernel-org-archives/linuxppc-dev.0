Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A4D7DE0AF
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 00:19:49 +1000 (EST)
Date: Tue, 29 Jul 2008 23:18:35 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 5/5] sh: Define elfcorehdr_addr in arch dependent section
Message-ID: <20080729141835.GC902@linux-sh.org>
References: <20080727234529.GM6175@verge.net.au>
	<20080728015117.GA12055@verge.net.au>
	<20080728024526.GB3334@verge.net.au>
	<20080728034007.GA30450@verge.net.au>
	<20080728211025.GA9985@redhat.com>
	<20080728211156.GB9985@redhat.com>
	<20080728211314.GC9985@redhat.com>
	<20080728211408.GD9985@redhat.com>
	<20080728211514.GE9985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080728211514.GE9985@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Terry Loftin <terry.loftin@hp.com>,
	Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 05:15:14PM -0400, Vivek Goyal wrote:
> o Move elfcorehdr_addr definition in arch dependent crash dump file. This is
>   equivalent to defining elfcorehdr_addr under CONFIG_CRASH_DUMP instead of
>   CONFIG_PROC_VMCORE. This is needed by is_kdump_kernel() which can be
>   used irrespective of the fact whether CONFIG_PROC_VMCORE is enabled or
>   not.
> 
> o I don't see sh setup code parsing the command line for elfcorehdr_addr. I 
>   am wondering how does vmcore interface work on sh. Anyway, I am atleast
>   defining elfcoredhr_addr so that compilation is not broken on sh.
> 
Hmm, you are correct, it seems like it was either lost in a merge
somewhere or I simply neglected to check it in it when I was testing this
stuff initially. Thanks for noticing!

> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>
