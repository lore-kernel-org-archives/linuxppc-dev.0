Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEBE23@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Hash_base 
Date: Thu, 15 May 2003 14:48:20 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The hashtable.S defined: Hash_base = 0xc0180000. How and where
was this address (range) mapping setup ? in BAT or page mode ?

Aother question is when code is running in exception context,
does MSR[IR] and MSR[DR] always turned on ?

Thanks.

Bo Yu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
