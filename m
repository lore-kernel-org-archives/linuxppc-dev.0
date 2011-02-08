Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id A4FA1B7176
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 13:17:08 +1100 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.54])
	by hrndva-qmta04.mail.rr.com with ESMTP
	id <20110208021206499.ZWFD2580@hrndva-qmta04.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Feb 2011 02:12:06 +0000
Subject: Re: PowerPC, ftrace: Add PPC raw syscall tracepoints & ftrace
	fixes (mimimal subset only) v4
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1296703645-18718-1-git-send-email-imunsie@au1.ibm.com>
References: <1296703645-18718-1-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 07 Feb 2011 21:10:56 -0500
Message-ID: <1297131056.23343.8.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Andreas Dilger <adilger@dilger.ca>, Andreas Schwab <schwab@linux-m68k.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Namhyung Kim <namhyung@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
	Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <agraf@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Nathan Lynch <ntl@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, David Gibson <dwg@au1.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-02-03 at 14:27 +1100, Ian Munsie wrote:
> Hi All,
> 
> This is a partial version of my 'ftrace syscalls, PowerPC: Various fixes,
> Compat Syscall support and PowerPC implementation'. This is updated from
> yesterday with arch_syscall_addr changed to a static inline function from
> Steven's suggestion.
> 
> This subset implements the raw syscall tracepoints on PowerPC which has been
> requested recently.  It also fixes ftrace syscalls to ensure that events will
> only be created for syscalls that successfully map their metadata to a syscall
> number, so that non-working phantom events are not created. Patches #2 and #6
> in this series are not strictly necessary for this, they just optimise ftrace
> syscalls a bit.
> 
> What's missing from this series that was in the full 40 patch v2 series is the
> conversion of all the syscalls implemented under /arch/powerpc, Jason Baron's
> compat syscall support and the conversion of the remaining native and compat
> syscalls to this infrastructure.

Thanks Ian,

I'll pull this into my local repo and start running my tests on it.

-- Steve
