Message-Id: <200009120614.IAA00922@piglet.grunz.lu>
Date: Tue, 12 Sep 2000 08:14:15 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Getting patches in (was: Re: Roles for distributions)
To: greyham@research.canon.com.au
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000912042454.D7D1F208@elph.research.canon.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  12 Sep, this message from Graham Stoney echoed through cyberspace:
>> I think it's better to pick something which doesn't work and you would like it
>> to, then start digging into it instead of looking for 'the right one which
>> needs help the most' where you aren't in it with your heart and soul. :)
>
> This is good advice, but it's only half the problem -- and it's the relatively
> easy half at that.  I found that kernel profiling for ppc in v2.2 didn't work
> for me (didn't work at all in fact), so I fixed it and published the patch all
> over the place, including at:
>     http://members.nbci.com/greyhams/linux/patches/2.2/profile.patch
>
> However, the intractible part is getting my fix into the official sources.

I found this to be a major pain as well.

> I'm not working for a distribution; maybe it would be easier if I was.
> I'm just a user who doesn't want to have to keep reapplying my patches every
> time I get a new release, and would like to fix stuff properly so the next
> guy who comes along has an easier time than I did.  It's not at all clear how
> to get fixes in even once you've dug up the solution.

I agree that this seems to be a major problem of the PPC Linux port at
this time. It is not clear at all how the flow of patches from user
contribution, to PPC kernel tree, to Linus' tree is happening... and
unfortunately, too often, it just isn't happening.

I've sent lots of patches to those people I thought were 'platform
maintainers', only to notice weeks or months later, that a few kernel
releases later they were not in there. Patches just disappeared into the
void, no reaction at all. _That_ is frustrating. If patches are refused
for some reason, then fine, I've not done my homework, let me try again.
But without any reaction, I haven't even gotten that chance.

Anyway, the best advice I can give you right now is:

- post patches here
- post patches on sourceforge to the ppclinux project
- send patches to Paul Mackerras (PowerMac stuff), or Cort Dougan
  (general PPC stuff), but don't expect any reaction. It does help,
  though, sometimes.

At the moment, BenH is actively tracking the patches on sourceforge. I
do jope others will follow his example, and I also hope that more people
will use sourceforge. Try it out, it's really esay ;-)

Cheers (I mean it ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
