From: Benjamin Herrenschmidt <bh40@calva.net>
To: Jon Erick Ween <jween@som.llu.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
Date: Wed, 27 Sep 2000 22:35:16 +0200
Message-Id: <19340822140700.24207@192.168.1.10>
In-Reply-To: <B5F794D8.631%jween@som.llu.edu>
References: <B5F794D8.631%jween@som.llu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Here's a copy of my XF86Config file.
>
>Two other minor nuisances:
>
>Since using yaboot, my console cursor has disappeared. Is this an OF or a
>yaboot problem? It's very hard to navigate in vi to edit anything (.config
>files for one thing) without a cursor!

Completely ? Or does it appear with different colors depending on the VC
you are on ? I've seen such bug appear here or there but never took the
time to track it down...

I suspect an atyfb problem ;)

>Also, I can't figure out how to uninstall BootX. Throwing it away under
>MacOS doesn't seem to help.

Remove the bootx extension that is in your MacOS Extensions folder. it
should appear near the top of the list when vieweing them by name.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
