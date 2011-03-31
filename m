Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 74483B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 07:39:02 +1100 (EST)
Subject: Re: mmotm threatens ppc preemption again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <4D94B810.4000107@goop.org>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>
	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>
	<1300672207.2402.205.camel@pasglop>
	<alpine.LSU.2.00.1103201901340.7257@sister.anvils>
	<1300674150.2402.207.camel@pasglop>
	<20110330135332.9c322e40.akpm@linux-foundation.org>
	<4D939B88.5020707@goop.org> <1301532729.2407.16.camel@pasglop>
	<4D94B810.4000107@goop.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 07:38:38 +1100
Message-ID: <1301603918.2407.70.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-03-31 at 10:21 -0700, Jeremy Fitzhardinge wrote:
> 
> No, its the same accessors for both, since the need to distinguish them
> hasn't really come up.  Could you put a "if (preemptable()) return;"
> guard in your implementations?

That would be a band-aid but would probably do the trick for now
for !-rt, tho it wouldn't do the right thing for -rt... 

> Otherwise I have no objections to passing the mm in (we'll probably just
> continue to ignore the arg in x86-land).

Ben.
