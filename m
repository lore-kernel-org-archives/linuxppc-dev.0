To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] enhancements to MPC8260 FCC driver ...
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-12417651260"
Date: Tue, 28 May 2002 15:40:18 +1000
Message-ID: <17970.1022564418@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_-12417651260
Content-Type: text/plain; charset=us-ascii


enhancements to MPC8260 FCC driver ...

- support for Davicom DM9131 PHY (plus minor typo in comment fix)
- minor change to the way the ethernet address supplied in the board info
  struct is assigned to the three ethernet ports; the address is used as
  is for FCC1, then same bits as before bits are xor'd rather than or'd
  for the other two (to ensure different ethernet addresses, although I'm
  not sure this is really necessary - could just use the supplied address
  for all three)

Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


--==_Exmh_-12417651260
Content-Type: application/x-gzip ; name="fcc.patch.gz"
Content-Description: fcc.patch.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="FCC_PATC.GZ"

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
bxX56rSAluQnerAhXt7f9H8BRiveVRgQAAA=

--==_Exmh_-12417651260--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
