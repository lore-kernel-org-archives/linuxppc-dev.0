Date: Mon, 13 Aug 2001 15:28:01 +0100
Subject: Re: Fix for PPC audio devices that can't reendianize samples
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Derrik Pates <dpates@dsdk12.net>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010813142736.E9223DBA0D@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 13, 2001,  Derrik Pates wrote:
> On Sun, 12 Aug 2001, Iain Sandoe wrote:
>> Well, actually, I'd like to lose all the translation stuff (rate conversion,
>> format conversion etc.).  This belongs in User-Land and is preventing me
>> from implementing mmio (which would be useful for the more serious
>> applications).
> Ok, so why not just take it out, and have the driver printk() a message if
> userspace tries to force it to accept an audio format it doesn't know,
> saying basically, "Please ask the developers of the software to properly
> query the OSS device for supported formats"?

OK.  This is maybe a way forward.

However, at the moment, I'm thinking about a bigger restructuring of the
driver to handle all the newer hardware types.  Depending on how Ben H sees
this - it may be left 'till 2.5 - rather than breaking existing 2.4.x
behaviour.  (not to mention the fact that it's not happening ATM owing to
lack of time ;-)

>If that's really the way you'd prefer it to be,

errm ... I went round the loop you did ...

- it's the way that Linus & co. want it to be ... and, of course, once one
looks at it a little harder, makes perfect sense.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
