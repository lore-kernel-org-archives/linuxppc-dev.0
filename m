To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A few questions.
References: <87k738ph42.fsf@hades.nocrew.org>
	<1075545982.4501.93.camel@gaston> <8765esp1gt.fsf@hades.nocrew.org>
From: Stefan Berndtsson <stefan@nocrew.org>
Date: Mon, 02 Feb 2004 09:36:55 +0100
In-Reply-To: <8765esp1gt.fsf@hades.nocrew.org> (Stefan Berndtsson's message
 of "Sat, 31 Jan 2004 16:44:18 +0100")
Message-ID: <87r7xdkhco.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stefan Berndtsson <stefan@nocrew.org> writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
>> On Sat, 2004-01-31 at 21:06, Stefan Berndtsson wrote:
>>> First question:
>>>
>>> What is the status of m3mirror:ing with an ibook2 (600MHz from 2001)
>>> using a 2.6 kernel? There was some patch sent out a long time ago, but
>>> I couldn't get it to apply in any sensible way.
>>
>> That doesn't quite work yet. Someday, somebody (me ?) has to
>> spend the time & dedication to setup the second output properly
>> once for all =P
>
> Ok, in the meantime, I took a patch for 2.4 and brutally stuffed it into
> a 2.6.2-rc1-ben1. With some minor tweaking it now seems it actually works.

After some more brief tests, it seems that, although the mirroring works,
changing the resolution on the machine stops the working mirror until a
reboot takes place and reinitialises something. I don't know if this was
the case with the patch used on 2.4, but I suspect it was.

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
