Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B6D6B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 13:05:57 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 13C3ADDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 13:05:56 +1000 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Steven Rostedt <rostedt@goodmis.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4AA88F7D.5030302@in.ibm.com>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252525364.27001.32.camel@gandalf.stny.rr.com>
	<4AA88F7D.5030302@in.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Sep 2009 23:05:53 -0400
Message-Id: <1252638353.18996.62.camel@gandalf.stny.rr.com>
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

On Thu, 2009-09-10 at 11:02 +0530, Sachin Sant wrote:
> Steven Rostedt wrote:
> > Ah, seems the bug happens to be in the module handling. Does the call
> > back always have .mod_return_to_handler?
> >   
> Yes. Every time it ends up in .mod_return_to_handler

BTW, do you have CONFIG_IRQSTACK set?

-- Steve
