Date: Sat, 22 Jan 2000 18:18:53 -0500
From: brad allison <jackal@aol.net>
To: Stephen Edie <sedie@terraplex.com>
cc: Tom Rini <trini@kernel.crashing.org>,
        Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB problems in 2.2.14pre9
In-Reply-To: <Pine.LNX.4.10.10001211550440.9693-100000@newhope.terraplex.co
 m>
Message-ID: <Pine.SGI.4.00.10001221817140.24320-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




But I'm only pressing a maximum of _two_ keys "cd" and it's coming out as
"cdcd".

It's a real pain cause I do "cd" a lot.

I'm sure they are getting pressed somewhat at the same time cause I do it
so fast but still it shouldn't be glitching on that.

Also, I didn't see this problem in the 2.2.6.

-b


On Fri, 21 Jan 2000, Stephen Edie wrote:

>
> > Using a more current stack (2.3.40) I can use up to 6 keys (ie press 'em
> > one after another and the last pressed one works) and the 7th is ignored.
>
> Hmm, I also noticed that some combinations of keys will glitch on the
> 3rd keystroke.  Thinking about back when I learned about low-level
> keyboard stuff, I think that some keyboards can only handle a certain
> number of keys down or they report a "too many keys" code.  Perhaps this
> code is not being handled correctly?  Or, maybe I'm just on crack.  (Hard
> to say considering the way my day is going today)
>
> Stephen
>
> Terra Soft Solutions, Inc.
>  Yellow Dog Linux
>  "The Ultimate Companion for a Dedicated Server"
>  http://www.yellowdoglinux.com/
>
>  Black Lab Linux
>  Workstations and advanced, Parallel Solutions
>  http://www.blacklablinux.com/
>
> On Fri, 21 Jan 2000, Tom Rini wrote:
>
> >
> > ---
> > Tom Rini (TR1265)
> > http://gate.crashing.org/~trini/
> >
> >
>
>

--
AOL SAPI    jackal@aol.net    jackal@kmfms.com    703.265.0908   AIM:jackal242
http://jackal.fudge.org        `I was never more certain of how far away I was
from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
