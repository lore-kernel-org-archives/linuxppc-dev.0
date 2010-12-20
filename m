Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 5E3E9B6EF1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Dec 2010 08:12:11 +1100 (EST)
Subject: Re: Oops in trace_hardirqs_on (powerpc)
From: Steven Rostedt <rostedt@goodmis.org>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
In-Reply-To: <1292877806.22905.62.camel@gandalf.stny.rr.com>
References: <20100806233157.GA7117@alea.gnuu.de>
	<1285184671.26872.127.camel@gandalf.stny.rr.com>
	<20100927125037.GA4497@alea.gnuu.de> <1285639094.2989.1.camel@frodo>
	<20101219132705.GE6615@alea.gnuu.de>
	<1292877806.22905.62.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 20 Dec 2010 16:12:09 -0500
Message-ID: <1292879529.22905.63.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-12-20 at 15:43 -0500, Steven Rostedt wrote:

> Anyway, it looks like this only affects 32 bit PPC as I can't reproduce
> it with my 64 bit one. And also, unfortunately, my 32bit ppc got taken
> from me by my kids, so I can't test it on that either.


Spoke too soon, I just triggered it on 64bit.

I'll look into it. Thanks!

-- Steve
