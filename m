Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C19@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'RSR - Piero Dominioni'" <pdominioni@rsr.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: NFS mount for TQM823L
Date: Thu, 27 Sep 2001 11:03:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> but your hint is correct only in one direction:

Sorry, I stopped reading further... ;-)

To be able to export and mount you target's /, enabling the kernel option is
needed but not enough.
You need the portmapper (portmap), NFS daemon (rpc.nfsd), NFS mount daemon
(rpc.mountd).
I'm not sure, but you may also need the remote quota server (rpc.rquotad).
Of course, you should have a valid /etc/exports file.

All this comes from the standard NFS control script.
Refers to the nfs-utils package (http://sourceforge.net/projects/nfs/)
in the script file 'etc/nodist/nfs-server'.
You can even use it directly to start the NFS server.

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
