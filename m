Return-Path: <dhowells@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A3E13B7E59
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 19:38:46 +1000 (EST)
Received: from mx2.redhat.com (unknown [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 3331DDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 19:38:45 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.LFD.2.00.0908190022570.3361@localhost.localdomain>
References: <alpine.LFD.2.00.0908190022570.3361@localhost.localdomain>
	<DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: spin_is_locked() broken for uniprocessor?
Date: Wed, 19 Aug 2009 10:38:06 +0100
Message-ID: <7099.1250674686@redhat.com>
Sender: dhowells@redhat.com
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
	Linux-Kernel List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Gleixner <tglx@linutronix.de> wrote:

> > which implies to me that spin_is_locked() will always return false.  Is this
> > expected behavior.
> 
> That's wrong. spin_is_locked should always return true on UP.

Surely it's not that simple?  Maybe spin_is_lock() should be undefined on UP.

David
