Message-ID: <383ADB77.C06460C4@mvista.com>
Date: Tue, 23 Nov 1999 10:22:47 -0800
From: Christian Zankel <chris@mvista.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: cort@fsmlabs.com, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
References: <19991122120429.031138@mailhost.mipsys.com> <19991122143732.B12973@hq.fsmlabs.com> <3839CF18.5D600DE@mvista.com> <19991122165535.A13360@hq.fsmlabs.com> <383A0AA4.1E4227DC@mvista.com> <19991122204001.A14117@hq.fsmlabs.com> <383A3610.BF976EDF@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan,

Dan Malek wrote:
> Cort Dougan wrote:
> > Yes, I do walk along that path quite often :)

> > } head.S. (Try to walk along the 'path' of the 8xx implementation).
> 
> OK, I am a little clueless at this hour.  As it appears you are
> making fun of the way I wrote that code, perhaps you should
> provide a suggestion.  I have more, the 82xx looks just like
> that :-)......I am off to look at the m68k tree......

I'm sorry, I didn't want to make fun or criticize any of you. In fact, I
think you did a very good job. And I don't want to touch most of the
code at all. I just would like to rearrange them slightly. So, what I
wanted to say is, that when I first brought up linux on that board I
went through several files and whenever I found a #if(n)def CONFIG_8xx I
knew that I had to add another condition. That was what I meant with
'walking along the patch of the 8xx implementation'. However, that might
end up in having very long lines like this one
#if (CONFIG_8xx = 1) || (CONFIG_BOARDA = 1) || CONFIG_BOARD_C = 1) [...]
at several positions in several files.

So, basically, what I wanted to ask you about, is, what you think about
rearranging some small part of the sources into dedicated machine
dependent files and if it is doable and if you know of any constraints
about the way to do it. Or, if you would suggest just to add another
machine into the current code.


Thanks,
Christian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
