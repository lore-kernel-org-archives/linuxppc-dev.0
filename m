Date: Sat, 27 May 2000 14:36:10 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Alain Birtz <abz@videotron.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Shared memory between module and application: is it possible ?
In-Reply-To: <392F0267.C7933983@videotron.ca>
Message-ID: <Pine.LNX.4.10.10005271431410.1728-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> How application can do to exchange data with module ?
>
> I know how to share memory between two application,
> but when I try to make the samething with module and application
> I get header confict:

I'd have the module allocate the memory, and mmap it from the application.
You can't use the SYSV IPC syscalls from the kernel (you might be able to
access the IPC data structures from the kernel some other way but that's a
bit risky).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
