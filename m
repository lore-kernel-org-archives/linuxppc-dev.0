Date: Fri, 21 Jan 2000 15:54:29 -0700 (MST)
From: Stephen Edie <sedie@terraplex.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: brad allison <jackal@aol.net>,
        Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB problems in 2.2.14pre9
In-Reply-To: <Pine.LNX.4.10.10001211537070.782-100000@opus.bloom.county>
Message-ID: <Pine.LNX.4.10.10001211550440.9693-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Using a more current stack (2.3.40) I can use up to 6 keys (ie press 'em
> one after another and the last pressed one works) and the 7th is ignored.

Hmm, I also noticed that some combinations of keys will glitch on the
3rd keystroke.  Thinking about back when I learned about low-level
keyboard stuff, I think that some keyboards can only handle a certain
number of keys down or they report a "too many keys" code.  Perhaps this
code is not being handled correctly?  Or, maybe I'm just on crack.  (Hard
to say considering the way my day is going today)

Stephen

Terra Soft Solutions, Inc.
 Yellow Dog Linux
 "The Ultimate Companion for a Dedicated Server"
 http://www.yellowdoglinux.com/

 Black Lab Linux
 Workstations and advanced, Parallel Solutions
 http://www.blacklablinux.com/

On Fri, 21 Jan 2000, Tom Rini wrote:

>
> ---
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
