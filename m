Message-Id: <200003121551.QAA00488@piglet.grunz.lu>
Date: Sun, 12 Mar 2000 16:51:35 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: defconfig for pmac in 2.3.51 and up
To: toa@pop.agri.ch
cc: costabel@wanadoo.fr, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <38CB94D1.C443C343@pop.agri.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  12 Mar, this message from Andreas Tobler echoed through cyberspace:
>> > maybe a dump Q, but I don't find it. In the kernels before 2.3.51 (stable &
>> > devel) I could type 'make pmac_config' to get the most things set to my needs.
>> > Now in 2.3.51 this defconfig is away.
>> > Any idea? Neither on bitkeeper nor on linuxcare. Or are there new methods to
>> > make defconfigs for certain machines?
>> > I don't like to set every item by hand. (too much)
>>
>> Strange... When I say 'make pmac_config' in the 2.3.51 tree from
>> bitkeeper, it does
>> rm -f .config arch/ppc/defconfig
>> cp -f arch/ppc/configs/pmac_defconfig arch/ppc/defconfig
>>
>> The only thing that changed from older kernels is that the config files
>> now have their own subdirectory arch/ppc/configs/. But this should work
>> precisely as before.
>>
>> (digging a little further...) Oh I see, bitkeeper doesn't have the
>> complete collection of arch/ppc/configs/*_defconfig files any more; no
>> more chrp, pmac, or prep. I still have them from a previous version.
>> Weird...

Wouldn't this be a side-effect of trying to 'unify' all the PPC
configs? There's only a generic PPC config option as well, an no more
CONFIG_PMAC, CONFIG_PREP, CONFIG_CHRP etc.., thy are all replaced by
the single CONFIG_ALL_PPC.

I think it still makes sense, though, to keep the default configs for
each hardware type. Makes kernel config a lot easier...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
