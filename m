From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Highmem on PPC?
Date: Tue, 5 Feb 2002 20:47:05 +0100
Message-Id: <20020205194705.22532@smtp.wanadoo.fr>
In-Reply-To: <20020205124214.H6834@boardwalk>
References: <20020205124214.H6834@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> And let me know if you find something ;)
>
>:) You bet.  You're sure you're not seeing these hangs?  What are you
>using, dual 7400 with 1 GB RAM?

I don't have a machine with enough RAM to do highmem. Actually, I could
probably test by hacking max_lowmem to 256Mb on my dual 7400, but it's
my work prod. machine so it's a bit tricky to do such tests on it.
It's not even supposed to run linux most of the time ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
