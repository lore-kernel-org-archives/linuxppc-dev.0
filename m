Return-Path: <roland@redhat.com>
Received: from QMTA08.westchester.pa.mail.comcast.net
	(qmta08.westchester.pa.mail.comcast.net [76.96.62.80])
	by ozlabs.org (Postfix) with ESMTP id 7F759DDF99
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 16:46:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] 4xx hardware watchpoint support
In-Reply-To: Paul Mackerras's message of  Thursday, 22 May 2008 13:51:52 +1000
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
Message-Id: <20080522064613.088AB26FA24@magilla.localdomain>
Date: Wed, 21 May 2008 23:46:13 -0700 (PDT)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I would think there would be a different REQUEST value to mean "set a
> hardware breakpoint".  Roland McGrath (cc'd) might be able to tell us
> what other architectures do.

Other architectures don't give a good model to follow.  (If anything,
they just trivally virtualize their own idiosyncratic hardware.)

What I want to see done for this in the future is reviving and
finishing the hw_breakpoint work begun by Alan Stern, and porting
that to each arch's particular hardware features.  On that we'd
build any new interfaces in abstract machine-independent terms,
just describing the constraints of what the hardware can do,
rather than having the user interface involve mimicking hardware
encodings.  (The existing hardware-idiosyncratic ptrace interfaces
would tie into hw_breakpoint for backward compatibility.)


Thanks,
Roland
