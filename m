Message-Id: <200101032217.WAA29312@hyperion.valhalla.net>
Date: Wed, 03 Jan 2001 22:13:25 +0000
Subject: Re: esound and 2.2's dmasound
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Wed, 3 Jan 2001, Iain Sandoe wrote:
>>
>> > - the 2.4 dmasound backport doesn't work compiled in (and probably could be
>> >   updated for 2.2.18)
>>
>> it's probably a silly - like forgetting to call the init from within
>> drivers/char/mem.c  (that change has been made several times by both me &
>> Geert) but it seems to slip out of the diffs somehow)...
>
> There is (among other things)
>
> +#ifdef CONFIG_DMASOUND_AWACS
> +       dmasound_awacs_init();
> +#endif
>
> in char/mem.c...

ah well... not that then.

The last version I tried the back-port with was 2.2.18p20-ben1 (IIRC?) and
it worked then... since then I've been off-line...

So you might check the diffs between 2.2.18p17-20 and the final release.

It definitely worked built in and as module on the version named on my Linux
page... - having got caught out ;-) - I am now religious about testing my
stuff both built-in and as modules before posting it...

BTW:

I was not intending (when I do get back to it) - to work any more on 2.2 -
since there seems to be "0.5 * sqrt(damn_all)" chance that the back-port
would ever make it in to the 2.2.x kernel.

The intention is to work on things for 2.4/5/ALSA

- but if there's a few people who want a consolidated back-port for 2.2.18 -
I will do it... although it really needs to be hosted somewhere else if it
is going to be a long-term thing.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
