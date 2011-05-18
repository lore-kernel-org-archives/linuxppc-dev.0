Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 40E04B6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 09:39:52 +1000 (EST)
Message-ID: <4DD45673.3010007@goop.org>
Date: Wed, 18 May 2011 16:29:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmotm threatens ppc preemption again
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>	
	<1300665188.2402.64.camel@pasglop>	
	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>	
	<1300672207.2402.205.camel@pasglop>	
	<alpine.LSU.2.00.1103201901340.7257@sister.anvils>	
	<1300674150.2402.207.camel@pasglop>	
	<20110330135332.9c322e40.akpm@linux-foundation.org>	
	<4D939B88.5020707@goop.org> <1301532729.2407.16.camel@pasglop>	
	<4D94B810.4000107@goop.org> <1301603918.2407.70.camel@pasglop>
In-Reply-To: <1301603918.2407.70.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
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

On 03/31/2011 01:38 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2011-03-31 at 10:21 -0700, Jeremy Fitzhardinge wrote:
>> No, its the same accessors for both, since the need to distinguish them
>> hasn't really come up.  Could you put a "if (preemptable()) return;"
>> guard in your implementations?
> That would be a band-aid but would probably do the trick for now
> for !-rt, tho it wouldn't do the right thing for -rt... 

Hi Ben,

Have you had a chance to look at doing a workaround/fix for these power
problems?  I believe that's the only holdup to putting in the batching
changes.  I'd like to get them in for the next window if possible, since
they're a pretty significant performance win for us.

Thanks,
    J
