Date: Thu, 5 Jun 2003 11:00:33 +0900
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Wrong BAT mapping message in dmesg
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <7DDF51AB-96F9-11D7-8217-00039394E428@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I found a harmless bug in pgtable.c.  My machine has 144MB RAM, but
dmesg says "Memory BAT mapping: BAT2=128Mb, BAT3=16Mb, residual: 32Mb".
  It should be "(total_lowmem - __bat2 - __bat3) >>20" for residual,
isn't it?

Cheers,


P.S.
I recently created Linux-2.4 for NuBus PowerMac repository with
bitkeeper.  If anyone has interested in this, please look at
http://nubus-pmac.bkbits.net/.  This nubus tree is originally derived
from Takashi Oe's 2.4.6-pre3 patch, and I've maintained since
2.4.19-something.
--
Etsushi Kato
ekato@ees.hokudai.ac.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
