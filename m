Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C2F@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'RSR - Piero Dominioni'" <pdominioni@rsr.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: NFS mount for TQM823L
Date: Thu, 4 Oct 2001 12:18:44 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> While if we remote-execute it with
> # rpcinfo -p 126.126.126.107  (our target's IP)
> from the host's command line prompt we correctly obtain

Is your loopback interface properly configured with IP address 127.0.0.1?
Try:
  ipconfig lo 127.0.0.1
And then:
  rpcinfo -p

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
