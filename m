Date: Sat, 6 Apr 02 13:39:06 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204062139.AA17200@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I haven't look at the patch yet, but is my understanding correct that
> you have individual config options enabling the various board support
> and that you allow more than one to be selected at one time ?

Yes.

> If that is the case, then that's great. It's also what the arm ach does
> and I like it.

Good.

> Great ! Looks like you have more time than I do to spend on this.

It's just that I have a much greater need for it than you do. You guys using
PMacs can live with what you've got now, but I'm trying to make my own PPC
boards and I have to make mainline Linux support them in order to sell them,
so...

> I'll
> look at your patch and eventually get it merged asap.

Thanks!

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
