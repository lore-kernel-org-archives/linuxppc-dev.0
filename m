Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1542B70B3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 17:15:32 +1100 (EST)
Subject: Re: [PATCH] Ftrace : fix function_graph tracer OOPS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4AD56C05.9030602@in.ibm.com>
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
	<4AD56C05.9030602@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Oct 2009 17:15:20 +1100
Message-Id: <1255500920.2347.41.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-14 at 11:43 +0530, Sachin Sant wrote:

> Tested both the patches. Works fine.

Thanks !

Stephen, you merge these yourself or you need me to pick them up in
-powerpc ?

Cheers,
Ben.
