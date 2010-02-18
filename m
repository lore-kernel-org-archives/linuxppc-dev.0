Return-Path: <paulus@ozlabs.org>
Date: Thu, 18 Feb 2010 20:27:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] perf_event: e500 support
Message-ID: <20100218092706.GD24823@brick.ozlabs.ibm.com>
References: <20100115214351.GA2869@loki.buserror.net>
	<20100210222932.GA9844@brick.ozlabs.ibm.com>
	<4B7349F2.8030802@freescale.com>
	<20100211030143.GA11245@brick.ozlabs.ibm.com>
	<4B7436BC.10406@freescale.com>
	<2035B8E4-B957-4C66-938E-95C0312DABD3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2035B8E4-B957-4C66-938E-95C0312DABD3@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2010 at 09:33:06PM -0600, Kumar Gala wrote:
> Other than splitting the patch did you have any other changes you
> wanted to see before we'd get an Ack.  I'd like to see this go in
> for .34.

I thought it was a bit ugly having two different definitions of struct
power_pmu in perf_event.h with ifdefs.  Either give the two structs
different names or put them in different files.  That plus the
splitting out of the perf_callchain patch were my two main concerns.

Paul.
