MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16222.32829.717728.344331@cargo.ozlabs.ibm.com>
Date: Wed, 10 Sep 2003 11:37:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: Corey Minyard <minyard@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Change to allow signal handlers to set SE and BE bits.
In-Reply-To: <3F5E27D2.3090808@acm.org>
References: <3F4FB0F3.9090906@acm.org>
	<20030829131824.B18608@home.com>
	<3F574958.4090402@acm.org>
	<3F58AA89.80803@acm.org>
	<3F5E27D2.3090808@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Corey Minyard writes:

> I added some new syscalls for each sigreturn option, but there were
> already some more that would obviously not work for this.  Should I
> convert the others over to work correctly, or should I leave these like
> they are?

There already were numbers assigned for the sigreturn and rt_sigreturn
system calls which weren't being used in 2.4.  In 2.5/2.6 I have
changed the kernel to use them.  I thought the stack unwinding code in
glibc (at least) had already been updated to reflect that.

Which tree is your patch against?  Note that there are PPC signal
changes in 2.4.23-pre3.  I hope your patch is against the new version
not the old version. :)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
