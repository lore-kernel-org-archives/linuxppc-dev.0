Date: Fri, 4 Jan 2002 15:18:16 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jeremy Friesner <jaf@lcsaudio.com>
Cc: linuxppc-dev@lists.linuxppc.org, jeffk@jdkoftinoff.com
Subject: Re: Having linking problems with atomic_inc(), atomic_dec_and_test()
 in user app, help!
In-Reply-To: <02010319244002.11251@jeremy>
Message-ID: <Pine.LNX.4.33.0201040922450.15701-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Also, what does "relocation truncated to fit: R_PPC_REL24 atomic_inc(atomic_t
> *)" mean?

About as much as 'unresolved external reference'. atomic_inc isn't defined
in the scope of your code. Look at the kernel headers; it might be inside
#ifdef __KRENEL__ (actually it is).

Why do you think you need to use atomic_inc directly instead of some
pthreads wrapper?

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
