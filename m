Date: Fri, 25 Jan 2002 05:59:32 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Radeon DRI support patch
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.43.0201241431430.29327-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16TySf-000098-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Jan, this message from Derrik Pates echoed through cyberspace:
>
> On Thu, 24 Jan 2002, daRonin wrote:
>
>> I install benh kernel and applied your patches on my new Powerbook Titanium.
>>
>> Seems to be working, it's nice to get more than 400FPS. Unfortunately it still seems to be a bit flaky.
>>
>> It does freeze the machine randomly when running GLX apps.
>
> That's the ever-lovely UniNorth AGP adding joy to your day. Ben's still
> working on getting the kinks out of supporting it - it's weird.

By chance, this would not be something comparable to what has been
discovered for the athlon processor under linux recently? Namely cache
coherency problems between processor and AGP.

>From what I understood (which may be wrong ;-) AGP gart is non-coherent
(by design?) . So, if the processor has a _cacheable_ mapping for the
same memory as the AGP card also has, there can be coherency problems if
the (valid) data in the processor's cache is modified by the AGP card
before the processor writes the cache line back to memory.

It was also mentioned that the erronous behaviour was related to
speculative writes, which are also use on the PPC processors.

Just a shot in the dark...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
