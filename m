Return-Path: <SRS0+5a975b97460a6157554b+1319+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: David Woodhouse <dwmw2@infradead.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4612EA16.7070102@am.sony.com>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<1175636904.10567.8.camel@shinybook.infradead.org>
	<4612D8FE.1070400@am.sony.com> <200704040055.36173.arnd@arndb.de>
	<4612EA16.7070102@am.sony.com>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 20:10:02 -0400
Message-Id: <1175645402.10567.38.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 16:58 -0700, Geoff Levand wrote:
> But you seem to say we can do something in the first stage kernel and pass
> some info to the second stage kernel?  The trouble with that is that when
> the kernel is used as a first stage, where does the info come from? 

>From the bootwrapper, surely? If the bootwrapper sets up the initial
device-tree and passes it to the first stage kernel, then all that
information will be passed through when you kexec the second stage
vmlinux.

-- 
dwmw2
