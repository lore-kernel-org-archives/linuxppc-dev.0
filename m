To: "Iain Sandoe" <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org, cpg@aladdin.de
Subject: Re: Sound problem on Blue G3
From: Christian Groessler <cpg@aladdin.de>
Date: 23 Apr 2001 00:52:16 +0200
Message-ID: <87pue4a6ov.fsf@gibbon.cnet.aladdin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 04/22/2001 11:42:48 PM CET "Iain Sandoe" wrote:
>
>Hi Christian,
>
>I take it from the first part of your message that sound is OK on the
>g3/beige (I certainly hope so - that's the machine I test most on ;-)

Yes. There it works. (Tested with doom and xmame and "cat xxx >
/dev/dsp")

>> I tried the current PPC patches from kernel.org (patch-2.4.4-pre4.bz2
>> and linuxppc2.4_vs_v2.4.4-pre4.patch.bz2), but except for a rename of
>> the sound driver module (dmasound_awacs -> dmasound_pmac) nothing
>> changed (I.e. the sound still doesn't work!)
>
>Hmm.  can you send me the output of "cat /dev/sndstat" please. and tell me
>if you have the "burgundy" sound chip (I think you do).

Here's /dev/sndstat:
PowerMac (AWACS rev 100) DMA sound driver rev 016 :
Core driver edition 01.01 : Built-in Sound driver edition 00.01
        sound.format = 0x8 (unsigned 8 bit)
        sound.speed = 8000Hz (phys. 44100Hz)
        sound.stereo = 0x0 (mono)
        sq.block_size = 32768 sq.max_count = 4 sq.max_active = 4
        sq.count = 0 sq.rear_size = 9568
        sq.active = 0 sq.syncing = 0

How do I know whether I have the "burgundy" sound chip?

>> How can I get the sound working on the Blue G3?
>
>well, you could try applying the following two patches (I updated earlier
>this pm):
>
>ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.4p4-dmasound/dmas-2.4.4
>p4-1.diff.bz2
>
>and
>
>ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.4p4-dmasound/dmas-2.4.4
>p4-2.diff.bz2
>
>(both need to be applied)... you should be able just to "make dep modules"
>and "make modules_install" and go from there.

I will do tomorrow (it's late by now)


>what desktop?
>could you make sure that things aren't getting futzed by the mixer - I know
>this sounds a little dumb - but could you try adjusting the levels of
>speaker and input... even if they look like they are OK.

I thought of this myself, but I installed some mixer programs and xmcd
and set the level to full in all of them. No avail. xmcd starts the CD
but nothing comes out of the speakers.

regards,
chris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
