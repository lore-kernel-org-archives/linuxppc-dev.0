Message-Id: <199902240714.IAA00361@piglet.cpu.lu>
Date: Wed, 24 Feb 1999 08:14:18 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: egcs-1.1.1-1c bug (was Re: major ksyms problem)
To: thomassr@erols.com
cc: nester@erols.com, Franz.Sirl@munich.netsurf.de,
        mklinux-development-system@public.lists.apple.com,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.9902231559510.6465-100000@localhost.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  23 Feb, this message from Tom Vier echoed through cyberspace:
[snip]
>> >egcs-1.1.1-1c failed using -O0, -O2, and -O3 with all combinations of
>> >-mcpu=601, -mcpu=604, and -fno-schedule-insns. -fpic did work, however
>> >it addes an offset table symbol that makes insmod complain.
>> >> > Feb 21 09:36:18 zero insmod: /lib/modules/2.0.37-osfmach3/net/bsd_comp.o:
>> >> > Unhandled relocation of type 26 for .L343
>> 
>> Is "Unhandled relocation of type 26" the behaviour for standard compilation
>> or for -fpic? You can't compile a kernel/modules with -fpic and expect
>> modutils still to work, modutils only handles the minimum necessary
>> relocation types.

Just to make sure we all talk about the same things, there was an issue
with relocation of kernel modules some time ago when we moved to a
newer version of egcs, which needed a newer version of modutils to be
able to handle that new relocation.

The modutils version to use is 2.1.121. If nowhere else, you can find a
binary on my site (see below).

Now, I may be completely off track, and this problem now is something
completely different ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
