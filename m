Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91A02B6F15
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 02:18:19 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAUF7BQO016944
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 10:07:11 -0500
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAUFIFVn136482
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 10:18:15 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAUFHr6Y005993
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 08:17:53 -0700
Subject: Re: hypervisor call tracepoints  hcall_stats touchup.
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: rostedt@goodmis.org
In-Reply-To: <1259183974.21397.73.camel@gandalf.stny.rr.com>
References: <1259165529.16349.191.camel@lexx>
	<1259183974.21397.73.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Nov 2009 09:17:52 -0600
Message-ID: <1259594272.16349.393.camel@lexx>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, mingo@redhat.com,
	Anton Blanchard <anton@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-25 at 16:19 -0500, Steven Rostedt wrote:
> On Wed, 2009-11-25 at 10:12 -0600, Will Schmidt wrote:
> 
> > Tested-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> > Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> 
> Isn't it assumed that the one that made the patch also tested it? Well I
> would hope that is the norm.

I like to make that assumption, but wanted to be clear on the point for
anyone with doubts. :-)


> 
> -- Steve
> 
> 
