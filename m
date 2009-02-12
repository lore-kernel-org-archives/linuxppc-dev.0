Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 2645CDDF14
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 10:51:36 +1100 (EST)
Date: Thu, 12 Feb 2009 18:51:34 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 0/7][RFC] function graph tracer port to PowerPC
In-Reply-To: <4994B466.5050102@am.sony.com>
Message-ID: <alpine.DEB.1.10.0902121851250.15469@gandalf.stny.rr.com>
References: <20090212011051.265346435@goodmis.org>
	<4994B1A3.8080502@am.sony.com>
	<alpine.DEB.1.10.0902121840590.15469@gandalf.stny.rr.com>
	<4994B466.5050102@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 12 Feb 2009, Geoff Levand wrote:

> On 02/12/2009 03:41 PM, Steven Rostedt wrote:
> > On Thu, 12 Feb 2009, Geoff Levand wrote:
> > 
> >> On 02/11/2009 05:10 PM, Steven Rostedt wrote:
> >> > This is the port to PowerPC of the function graph tracer that was written
> >> > by Frederic Weisbecker for the x86 architecture.  It is broken up
> >> > into a series of logical steps.
> >> 
> >> I added these to my ps3-linux.git tree.  Very casual testing shows
> >> they seem to work OK.
> >> 
> >> 
> >> Tested-by: Geoff Levand <geoffrey.levand@am.sony.com>  Working OK on PS3.
> > 
> > Thanks!
> > 
> > Is the ps3 64 or 32 bit? I'll put your tested by on the appropriate 
> > patches.
> 
> It uses the Cell processor, which is 64 bit.

Thanks guys!

-- Steve
