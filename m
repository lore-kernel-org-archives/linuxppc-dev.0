Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093B04@mail1.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Jim Lin'" <jimmlin@solomon.com.tw>
Cc: linuppc <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Poor 8xx SCC Ethernet mode performence..
Date: Wed, 17 Jul 2002 16:11:31 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim,

> 4. Due to custom board running in  NFS  envirment . It's cost
> some throughput.. now I trying test it without NFS envirment.
>     If I got more  information  I will post again.

Send your incoming file to /dev/null to eliminate the NFS cost.
Example:
  ftp> get bigfile /dev/null

Then your measure with FTP will be more precise.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Quebec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
