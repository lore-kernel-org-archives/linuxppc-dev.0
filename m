From: bob@kunk.jriver.com
Message-ID: <20000123023047.6377.qmail@kunk.jriver.com>
Subject: Re: USB problems in 2.2.14pre9
To: linuxppc-dev@lists.linuxppc.org
Date: Sat, 22 Jan 2000 20:30:47 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> Wrote:
>On Fri, 21 Jan 2000, Stephen Edie wrote:
>
>>
>> Oh yes, I am using a USB keyboard right now.  It seems to happen whenever
>> more than three keys are simultaneously down...  When the fourth key is
>> pressed, it isn't reported.  At this point, releasing any of the four keys
>> causes duplicated key strokes to be reported.  Strange.
>
>Using a more current stack (2.3.40) I can use up to 6 keys (ie press 'em
>one after another and the last pressed one works) and the 7th is ignored.

I reported this several months ago. It has affected all kernels with the
new USB driver (post 2.2.6). I believe it is a side effect of the
USB-ADB translation. In effect you only get 2-key rollover instead of
n-key rollover. Haven't seen that since the 70's :)

It will be interesting to see if the 2.3.40 kernel works better. Judging
by Tom's comment, it looks like it's now 6-key rollover ;)

It's REAL easy to get the bad behavior by typing cd<space>
I ALWAYS get cdcd with this sequence. (note that the c and d keys aren't
released before the space is hit). It appears I'm not the ONLY one who types
like this....

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
