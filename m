MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Hardcoded Hash_base?
Date: Thu, 13 Mar 2003 12:44:50 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093BD8@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Kent Borg" <kentborg@borg.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In arch/ppc/mm/hashtable.S Hash_base is hardcoded at 0xc0180000, with
> a comment suggesting that that value is "just an example".  It seems
> to be colliding with my initrd, so I am thinking I want to move it.

As the comment says, this code is patched at runtime.
It is done by MMU_init_hw, in arch/ppc/mm/ppc_mmu.c.
The value of Hash_base could be anything, it doesn't matter.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
