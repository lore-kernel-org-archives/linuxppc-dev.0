From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030827220627.1e437823.pochini@shiny.it>
References: <20030824092456.3c36fa5b.pochini@shiny.it>
	 <1061714789.753.12.camel@gaston> <20030824174408.520f2cb3.pochini@shiny.it>
	 <1061740217.31688.33.camel@gaston>
	 <20030827220627.1e437823.pochini@shiny.it>
Message-Id: <1062059514.1293.112.camel@gaston>
Mime-Version: 1.0
Date: Thu, 28 Aug 2003 10:31:55 +0200
Subject: Re: Random crashes
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-08-27 at 22:06, Giuliano Pochini wrote:
> On Sun, 24 Aug 2003 17:50:17 +0200
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > > Random... lockups, oopses, sig11... but nothing useful because is happens
> > > in random places. Ok, so the answer is no. Maybe the hw is faulty. It's
> > > the only kernel I used on this mac.
> >
> > Strange. I haven't been reported such problems. Can you try an older kernel
> > just in case ? Could also be bad ram...
>
> I tried 2.4.22 and I replaced the RAM. Nothing. Digging in the oops
> collection I found this one which doesn't look very nice:
>
> Jul 23 21:37:55 localhost kernel: Machine check in kernel mode.
> Jul 23 21:37:55 localhost kernel: Caused by (from SRR1=20009030): L1 Data Cache error
>
> I'll send the machine back for repair, altought I think they'll not even
> notice the problem because it happens sporadically :(((

Well... I'm not 100% sure the message is correct, though from what you say,
it seems indeed there is a CPU fault...

What CPU is this exactly ? (/proc/cpuinfo)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
