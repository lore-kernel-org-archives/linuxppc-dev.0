MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Disabling data cache
Date: Wed, 2 Apr 2003 09:28:21 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B763543@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Matt Porter" <porter@cox.net>, "kas turi" <inox_kas@yahoo.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There is a kernel configuration option for that: CONFIG_DCACHE_DISABLE.
In the kernel configuration UI, look into the section 'MPC8260 CPM Options'.

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
