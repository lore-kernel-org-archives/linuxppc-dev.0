Date: Thu, 11 Feb 1999 20:31:04 -0600 (CST)
From: Ken Roberts <ken@worldnet.att.net>
Reply-To: Ken Roberts <ken.r@worldnet.att.net>
To: David Edelsohn <dje@watson.ibm.com>
cc: Rick Kwan <kenobi@coruscant.lightsaber.com>,
        linuxppc-dev@lists.linuxppc.org, rick.kwan@lightsaber.com
Subject: Re: PReP spec 
In-Reply-To: <9902110429.AA10400@marc.watson.ibm.com>
Message-ID: <Pine.LNX.3.96.990211200151.396E-100000@dancer.at.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ken> everything ibm made that's powerpc, i think, was prep or
>Ken> chrp.  all the current rs/6000's, as/400's, and system 390's are powerpc and
>Ken> chrp.  the older powerpc machines of these lines are, as far as i know, prep.
>	S/390 is neither PowerPC nor CHRP.  Recent AS/400 systems are
>PowerPC based.  I am not sure if any AS/400 systems are CHRP and not all
>RS/6000 systems are CHRP.

ok, i was mistaken about the 390.  i work at ibm rochester, and was told there
that everything ibm makes is ppc, excepting their intel systems.  since the 390
isn't ppc, it also can't be chrp.

however, everything as/400 that is in current production is powerpc, and i know
positively that the lower-end models are chrp.  the last i looked at the rs6k
site was when the s70 was released, which was the first power64 chip in
production.  as of that point, everything _new_ in the rs6000 line was a power
chip of some sort or another.  the older models are cisc.  i recall that the s70
was chrp, and some of the other new ones are chrp.  there's also a lot of prep
in there.

looking through the web pages right now, there's not a single mention of chrp
for ANY rs6000.  i know that there are at least some.

regardless, i'm not trying to start a war here.  i'm interested in finding the
truth, and appreciate your making me investigate further.  i was told that the
390's were ppc, but this can't be the case since the 390's have their own
special os-on-a-chip thing that is the hallmark of the 390.  i knew this, yet
somehow bought the idea that it was also powerpc, which just can't be.

i'll check out more on the as/400 and rs/6000 at work, and see if i can scare
up a list of chrp machines.  this may prove interesting for the linux project,
although i strongly suspect that device drivers on the 400 will be difficult to
come by.  there's an awful lot of 400-specific stuff out there.


-------------------------------------------------------------------------------
    Ken Roberts                                      ken.r@worldnet.att.net
                 Oft-times thou feelest like unto a nut,
                     And yet, M'lord, anon, feel'st thou not so.
                 Yon Almond Joy these selfsame nuts doth have,
                     Whereas contrary Mounds doth have them not.
                                 -- William Shakespeare, kind of


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
