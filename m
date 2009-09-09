Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 86BF8B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 11:05:22 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id D7B3ADDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 11:05:07 +1000 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Steven Rostedt <rostedt@goodmis.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A76BE81.4080707@in.ibm.com>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 21:05:03 -0400
Message-Id: <1252458303.20985.10.camel@gandalf.stny.rr.com>
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

On Mon, 2009-08-03 at 16:10 +0530, Sachin Sant wrote:
> Steven Rostedt wrote:
> > Thanks,
> >
> > I've seen issues with my PPC box and function graph, but the bugs were
> > also caused by other changes. I'll boot up my PPC64 box and see if
> > I see the same issues you have.
> >   
> Hi Steven,
> 
> I can still recreate this issue with 2.6.31-rc5. Let me know
> if i can provide any information to find a solution for this.

Hi Sachin,

I'm going through old email, and I found this. Do you still see this
error. I don't recall seeing it myself.

Thanks,

-- Steve
