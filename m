Message-Id: <200210091634.MAA28260@makai.watson.ibm.com>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: Re: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL? 
In-Reply-To: Message from Kevin Hendricks <khendricks@ivey.uwo.ca>
   of "Wed, 09 Oct 2002 11:12:36 EDT." <8B16CEB0-DB99-11D6-BCE2-0030654D6A26@ivey.uwo.ca>
Date: Wed, 09 Oct 2002 12:34:28 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Kevin Hendricks writes:

Kevin> Also, is anyone here actively working on Ulrich Drepper's New Posix
Kevin> Thread Library (NPTL) to add in support for ppc Linux?  Has anyone
Kevin> decided on what register will be used for Thread Local Storage on PPC
Kevin> (32bit)?  (Is this r13 on ppc64?).  Have the necessary modifications to
Kevin> the ABI/compiler been made to support a dedicated thread local storage
Kevin> register?

	There still is a question of what the final version of thread
support will look like in Glibc.  TLS support has not been added to
PowerPC GCC yet.  GPR 13 is reserved for the thread ID.  I do not know
whether that also can be used as the TLS base pointer.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
