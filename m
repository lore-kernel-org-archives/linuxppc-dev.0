Date: Wed, 27 Aug 2003 22:06:27 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Random crashes
Message-Id: <20030827220627.1e437823.pochini@shiny.it>
In-Reply-To: <1061740217.31688.33.camel@gaston>
References: <20030824092456.3c36fa5b.pochini@shiny.it>
	<1061714789.753.12.camel@gaston>
	<20030824174408.520f2cb3.pochini@shiny.it>
	<1061740217.31688.33.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Aug 2003 17:50:17 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > Random... lockups, oopses, sig11... but nothing useful because is happens
> > in random places. Ok, so the answer is no. Maybe the hw is faulty. It's
> > the only kernel I used on this mac.
>
> Strange. I haven't been reported such problems. Can you try an older kernel
> just in case ? Could also be bad ram...

I tried 2.4.22 and I replaced the RAM. Nothing. Digging in the oops
collection I found this one which doesn't look very nice:

Jul 23 21:37:55 localhost kernel: Machine check in kernel mode.
Jul 23 21:37:55 localhost kernel: Caused by (from SRR1=20009030): L1 Data Cache error

I'll send the machine back for repair, altought I think they'll not even
notice the problem because it happens sporadically :(((


--
Bye.
   Giuliano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
