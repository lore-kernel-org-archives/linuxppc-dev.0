Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C18@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'RSR - Piero Dominioni'" <pdominioni@rsr.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: NFS mount for TQM823L
Date: Thu, 27 Sep 2001 08:52:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The portmapper (portmap) and the lock daemon (rpc.lockd) are not running on
your target.
Either you start them, or just add option "-o nolock" when calling mount.
  # mount -o nolock -t nfs 126.126.126.106:/home /tmp


--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
