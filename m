To: David Edelsohn <dje@watson.ibm.com>
Cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: Re: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL?
References: <khendricks@ivey.uwo.ca>
	<200210091634.MAA28260@makai.watson.ibm.com>
From: Aldy Hernandez <aldyh@redhat.com>
Date: 03 Nov 2002 10:28:22 -0800
In-Reply-To: <200210091634.MAA28260@makai.watson.ibm.com>
Message-ID: <m3r8e2ld89.fsf@frogsleap.quesejoda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "David" == David Edelsohn <dje@watson.ibm.com> writes:

>>>>> Kevin Hendricks writes:

 Kevin> Also, is anyone here actively working on Ulrich Drepper's New Posix
 Kevin> Thread Library (NPTL) to add in support for ppc Linux?  Has anyone
 Kevin> decided on what register will be used for Thread Local Storage on PPC
 Kevin> (32bit)?  (Is this r13 on ppc64?).  Have the necessary modifications to
 Kevin> the ABI/compiler been made to support a dedicated thread local storage
 Kevin> register?

 > 	There still is a question of what the final version of thread
 > support will look like in Glibc.  TLS support has not been added to
 > PowerPC GCC yet.  GPR 13 is reserved for the thread ID.  I do not know
 > whether that also can be used as the TLS base pointer.

Funny I was just talking to Richard Henderson on the plane about this
last week.

David, I was thinking on working on TLS for PPC (gcc side of things),
but Kevin is right, we need to get a register and change the ABI, else
things can get really spooky.  I was thinking we could use r13 (?)
like PPC64 does.

I also vaguely recall that Geoff has a list of ABI changes pending.
Perhaps we should do all these at the same time.

Anywhoooo, we should probably discuss this on the gcc lis instead.

Aldy

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
