Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53854B7DB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 12:07:09 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4EC7Ehj012224
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 22:07:14 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4E202vq1331440
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 12:00:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4E276Nq028445
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 12:07:06 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 3/4] ftrace syscalls: Allow arch specific syscall symbol
	matching
From: Ian Munsie <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-reply-to: <1273794896.21352.203.camel@pasglop>
References: <1273736594-19320-1-git-send-email-imunsie@au1.ibm.com>
	<1273736594-19320-4-git-send-email-imunsie@au1.ibm.com>
	<1273794896.21352.203.camel@pasglop>
Date: Fri, 14 May 2010 12:06:41 +1000
Message-Id: <1273802608-sup-8186@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Benjamin Herrenschmidt's message of Fri May 14 09:54:56 +1000 2010:
> On Thu, 2010-05-13 at 17:43 +1000, Ian Munsie wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > Some architectures have unusual symbol names and the generic code to
> > match the symbol name with the function name for the syscall metadata
> > will fail. For example, symbols on PPC64 start with a period and the
> > generic code will fail to match them.
> > 
> > This patch splits out the match logic into a standalone weak function
> > that can be overridden on archs with unusual symbol names.
> > 
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > ---
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Ian, I assume you will implement the support for the "special" ppc_*
> syscalls via a subsequent patch and not a respin of this one right ?
> 
> Cheers,
> Ben.

Yes, that will be in a separate patch or two.

Cheers,
-Ian
