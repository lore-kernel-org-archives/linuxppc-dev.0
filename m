Subject: RE: setting persistent ulimit
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 11 Jul 2003 17:11:32 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED70303AC@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Miku Jha" <jha_miku@yahoo.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I wanted to know how can I set the
> ulimit -c size permanently to dump core.

This is done at the shell level.
Put your line in /etc/profile.
Read the manual pages for bash.

> ps:Do I need to recompile the kernel for this ?

No.

Regards,
--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
