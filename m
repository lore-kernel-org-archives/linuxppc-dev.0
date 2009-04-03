Return-Path: <fche@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 5B33CDDDF9
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 23:11:04 +1100 (EST)
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc ptrace block-step
References: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
	<1238650016.17330.193.camel@pasglop>
	<20090403004450.F2166FC3AB@magilla.sf.frob.com>
	<20090403011327.GA16881@zod.rchland.ibm.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: Fri, 03 Apr 2009 08:10:54 -0400
In-Reply-To: <20090403011327.GA16881@zod.rchland.ibm.com> (Josh Boyer's
	message of "Thu, 2 Apr 2009 21:13:27 -0400")
Message-ID: <y0meiwa0wfl.fsf@ton.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Roland McGrath <roland@redhat.com>,
	utrace-devel@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer <jwboyer@linux.vnet.ibm.com> writes:

> [...]  While I would love to believe that systemtap should work
> everywhere, I can't really see it running on an embedded board at
> this point.

FWIW, we have had people running (not compiling) systemtap probe
modules on embedded systems.  See "stap -p4" or "stap-server".

- FChE
