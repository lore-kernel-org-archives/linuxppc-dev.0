Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 39EA4B7125
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 03:54:51 +1100 (EST)
Subject: Re: [PATCH 5/6] ftrace, powerpc: Implement raw syscall tracepoints
	on PowerPC
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1297159672.14982.205.camel@pasglop>
References: <1296703645-18718-1-git-send-email-imunsie@au1.ibm.com>
	<1296703645-18718-6-git-send-email-imunsie@au1.ibm.com>
	<1297131028.23343.7.camel@gandalf.stny.rr.com>
	<1297159672.14982.205.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Tue, 08 Feb 2011 11:54:46 -0500
Message-ID: <1297184086.23343.10.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Andreas Dilger <adilger@dilger.ca>, Andreas Schwab <schwab@linux-m68k.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Namhyung Kim <namhyung@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
	Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <agraf@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
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

On Tue, 2011-02-08 at 21:07 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2011-02-07 at 21:10 -0500, Steven Rostedt wrote:
> > Ben,
> > 
> > How do you want to work this? Do you want to ack it and I take this
> > patch with the others through the tracing tree, or do you want to wait
> > till the tracing tree gets updated into mainline and then pull this in
> > though the ppc tree. As this touches a bit of the ppc side.
> 
> I was waiting to see what you were up to vs. the rest of the series :-)
> 
> I still need to review that one closely, at which point I'm happy for
> you to take it.

It survived my tests, I'm continuing with other patches for 39 and I
have no problem with Ian's patches.

-- Steve
