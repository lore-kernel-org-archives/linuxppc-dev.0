From: "Rob Taylor" <robt@flyingpig.com>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: (kinda OT) 8240 configuration registers
Date: Wed, 30 Aug 2000 14:37:37 +0100
Message-ID: <001801c01287$75f8f9f0$b400a8c0@eventhorizon>
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've just been reading through the DINK kahlua startup code (I'm looking to add
another board to the ppcboot project)) and I've got some code that accessing
configuration registers I cant seem to find any info on...

the code in  question is writing 0x800f_f0xx values to CONFIG_ADDR. The most I
can figure out is that it's writing to device 0x1e on bus 0x0f, but this doesn't
make sense... Does anyone know what's going on here?

Thanks,
Rob Taylor
FPS


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
