From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Hanley <sjh@wibble.net>,
	Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: addresses in xmon trace output?
Date: Thu, 28 Jun 2001 11:38:49 +0200
Message-Id: <20010628093849.893@smtp.wanadoo.fr>
In-Reply-To: <20010628120346.A627@wibble.net>
References: <20010628120346.A627@wibble.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>what are the addresses you see in an xmon trace output? I had a crash
>yesterday with benh 2.4.6-pre3 (rsynced two days ago) where typing x in xmon
>didnt recover normal operation of the machine.
>
>So the T command seemed to give some interesting numbers I assumed were
>addresses in the system map I could look up once I rebooted.

Paulus helped me fix a bug in the wakup code that could cause
the kernel MMU mappings to be trashed (VSIDs initialized
incorrectly) leading to all sort of crashes on wakeup and
possibly bogus xmon output.

If you resync the tree, you should get the fix.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
