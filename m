From: "Jim Lin" <jimmlin@solomon.com.tw>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: "linuppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Poor 8xx SCC Ethernet mode performence..
Date: Thu, 18 Jul 2002 09:32:01 +0800
Message-ID: <NFBBLLKCILMGHKJGDFGHMEMJCCAA.jimmlin@solomon.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
In-Reply-To: <2702075D4DE2B043BF5EB82E9CFAD45B093B04@mail1.mediatrix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi   Jean-denis:

It's about 860KBps , It's a amaze..

---------------------------------------------
ftp> get xbc /dev/null
local: /dev/null remote: xbc
200 PORT command successful.
150 Opening BINARY mode data connection for xbc (13172736 bytes).
226 Transfer complete.
13172736 bytes received in 14.92 secs (862.4 kB/s)


Thanks

-----Original Message-----
From: Jean-Denis Boyer [mailto:jdboyer@mediatrix.com]
Sent: Thursday, July 18, 2002 4:12 AM
To: 'Jim Lin'
Cc: linuppc
Subject: RE: Poor 8xx SCC Ethernet mode performence..



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
