Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 17577B6F15
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 22:02:50 +1000 (EST)
Message-ID: <4C234961.4060109@suse.cz>
Date: Thu, 24 Jun 2010 14:02:41 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 16/40] tags: recognize compat syscalls
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-17-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-17-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	John Kacur <jkacur@redhat.com>, WANG Cong <xiyou.wangcong@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stefani Seibold <stefani@seibold.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.6.2010 12:02, Ian Munsie wrote:
> From: Jason Baron <jbaron@redhat.com>
> 
> make tags.sh recognize the new syscall macros:
> 
> COMPAT_SYSCALL_DEFINE#N()
> ARCH_COMPAT_SYSCALL_DEFINE#N()
> 
> Signed-off-by: Jason Baron <jbaron@redhat.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Acked-by: Michal Marek <mmarek@suse.cz>

Michal
