From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Sym53c875 problem with last 2_5 updates
Date: Fri, 16 Mar 2001 09:38:47 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMIECEDAAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
  few days ago (I don't remember the exact date) I have resynced my local
repository of 2_5 and today I have recompiled a kernel. While before the
updates my sym53c875 based board had always worked fine, now the driver
unsuccesfully try to download script on the chip continually. I have seen
that the sym53c8xx.c file is changed, in fact I have correct the problem
replacing the new file with the old.
I have not found any mention of sym53c8xx.c change in the changesets at
http://www.bitmover.com:8888//home/ppc/linuxppc_2_5 so I have thinked it can
be an erroneous update ... it is possible ?

Stefano.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
