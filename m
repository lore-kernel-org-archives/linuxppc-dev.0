From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030824174408.520f2cb3.pochini@shiny.it>
References: <20030824092456.3c36fa5b.pochini@shiny.it>
	 <1061714789.753.12.camel@gaston> <20030824174408.520f2cb3.pochini@shiny.it>
Message-Id: <1061740217.31688.33.camel@gaston>
Mime-Version: 1.0
Date: Sun, 24 Aug 2003 17:50:17 +0200
Subject: Re: Random crashes
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-24 at 17:44, Giuliano Pochini wrote:
> On Sun, 24 Aug 2003 10:46:29 +0200
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > > I'm having random crashes on a dualG4 windtunnel and v2.4.22p6. Is there
> > > any known issue ?
> >
> > What do you mean by random crash ? Lockups ? Panics ? See anything in
> > console or logs ? Is this new to this kernel ?
>
> Random... lockups, oopses, sig11... but nothing useful because is happens
> in random places. Ok, so the answer is no. Maybe the hw is faulty. It's
> the only kernel I used on this mac.

Strange. I haven't been reported such problems. Can you try an older kernel
just in case ? Could also be bad ram...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
