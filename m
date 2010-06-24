Return-Path: <mmarek@suse.cz>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7573AB6F14
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 22:05:24 +1000 (EST)
Message-ID: <4C2349F3.7090207@suse.cz>
Date: Thu, 24 Jun 2010 14:05:07 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com> <20100623102931.GB5242@nowhere>
	<4C21E3F8.9000405@linux.intel.com>
In-Reply-To: <4C21E3F8.9000405@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: WANG Cong <amwang@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
	"Sam Ravnborg"@suse.de, Steven Rostedt <rostedt@goodmis.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	Simon Kagstrom <simon.kagstrom@netinsight.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.6.2010 12:37, Andi Kleen wrote:
> It also has maintenance costs, e.g. I doubt ctags and cscope
> will be able to deal with these kinds of macros, so it has a
> high cost for everyone using these tools.

FWIW, patch 16/40 of this series teaches 'make tags' to recognize these
macros: http://permalink.gmane.org/gmane.linux.kernel/1002103

Michal
