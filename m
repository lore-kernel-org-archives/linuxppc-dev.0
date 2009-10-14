Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 7F02AB7B76
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 23:12:17 +1100 (EST)
Subject: Re: [PATCH] Ftrace : fix function_graph tracer OOPS
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1255500920.2347.41.camel@pasglop>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252814877.26049.93.camel@gandalf.stny.rr.com>
	<1252816650.8375.70.camel@pasglop>
	<1252848060.26049.647.camel@gandalf.stny.rr.com>
	<1252873548.8375.73.camel@pasglop> <1252915227.8375.118.camel@pasglop>
	<1254749155.13160.6.camel@gandalf.stny.rr.com>
	<1254774039.7122.35.camel@pasglop>
	<1254775073.13160.13.camel@gandalf.stny.rr.com>
	<4ACC57C4.5010002@in.ibm.com> <1254906621.2409.1.camel@pasglop>
	<4ACDFC83.4080205@in.ibm.com>
	<1255489284.7113.3121.camel@gandalf.stny.rr.com>
	<4AD56C05.9030602@in.ibm.com>  <1255500920.2347.41.camel@pasglop>
Content-Type: text/plain
Date: Wed, 14 Oct 2009 08:12:14 -0400
Message-Id: <1255522334.7113.4223.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-14 at 17:15 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-10-14 at 11:43 +0530, Sachin Sant wrote:
> 
> > Tested both the patches. Works fine.
> 
> Thanks !
> 
> Stephen, you merge these yourself or you need me to pick them up in
> -powerpc ?
> 

Ben,

You can either pull from my repo (I synced with latest Linus), or you
can just suck in the patches. I can also resync with your repo if you
prefer.

Either way is fine with me. Just let me know which you did.

-- Steve
