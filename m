From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Patch to let Xpmac usb rev 9 work with new G4 Rage128Pro cards.
Date: Mon, 13 Mar 2000 20:05:04 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
Cc: Dan Burcaw <dburcaw@terraplex.com>
MIME-Version: 1.0
Message-Id: <00031320082600.00531@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi,

Attached is a patch that allows Xpmac to identify and work with the new
Rage128Pro cards that come in the latest G4 systems.

Please add this patch to the Xpmac source so that acceleration will be possible
for these new G4s.

Thanks,

Kevin

The patch is attached.  It is very short and short install fine over Xpmac from
the 3.3.6 src rpms.


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: application/x-gzip;
  name="Xpmac_rage128pro.patch.gz"
Content-Disposition: attachment; filename="Xpmac_rage128pro.patch.gz"
Content-Transfer-Encoding: base64

H4sICOmPzTgAA1hwbWFjX3JhZ2UxMjhwcm8ucGF0Y2gAldBBa4MwFAfwc/Mp3rrLSmJ5CWqdu9jZ
OKQOxI5dg8w4vEhx7SiMfvdFLUzGtOwdcvq9Py9/y7Kgyd81F96HPhz3y7flvtGfs11+gOe8Ac6B
Cx9XvmODQERCKf21MNsd694K4K4v0OfY2yAAyxPMBWreewgCArdVCTeFLqtaF3dpGKuNfI1DqeKN
Wr/EyqRmycKwnsCIADw5wg6N03VRlYRej02jhWFTsWnUxqLtGtfHws8hYfSk1qnMFKpEQjt4wsv8
qR4ld4eKd21wFGwFlKPDvK4PgK+RT0oG86wvGjI5hzOb0tFQR9f0dqi3nbbGdTLUidGE/gOzCZ0O
z07bswmcH9reyTcxWCjFmQIAAA==

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
