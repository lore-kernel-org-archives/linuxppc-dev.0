To: linuxppc-dev@lists.linuxppc.org
Cc: cpg@aladdin.de
Subject: Sound problem on Blue G3
From: Christian Groessler <cpg@aladdin.de>
Date: 23 Apr 2001 00:23:08 +0200
Message-ID: <878zksmv5f.fsf@gibbon.cnet.aladdin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm rather new to linuxppc and Macs.
I have now 2 Macs, a Beige G3 and a Blue G3 Tower.

The first one was the beige. The beige G3 can only boot with BootX,
but everything else seems to work. I use Debian 2.2 and stock Linux
2.4.3.

I set up the same configuration (Debian 2.2 and 2.4.3) on the blue G3,
and it works despite of the sound. The driver loads (modprobe
dmasound_awacs) but it is silent.

I tried the current PPC patches from kernel.org (patch-2.4.4-pre4.bz2
and linuxppc2.4_vs_v2.4.4-pre4.patch.bz2), but except for a rename of
the sound driver module (dmasound_awacs -> dmasound_pmac) nothing
changed (I.e. the sound still doesn't work!)

How can I get the sound working on the Blue G3?

Thanks for your help,

regards,
chris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
