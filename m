Date: Tue, 30 Apr 2002 13:21:47 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [patch] map flash from bi-recs
Message-ID: <Pine.LNX.4.30.0204301318540.3469-101000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="394922409-354102991-1020198107=:3469"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--394922409-354102991-1020198107=:3469
Content-Type: TEXT/PLAIN; charset=US-ASCII

Attached is a patch that implements a map driver for flash devices. The
flash info is found from bi-recs (the bd_t board info struct right now).

It should apply cleanly against the current linuxppc_2_4_devel tree.

--394922409-354102991-1020198107=:3469
Content-Type: APPLICATION/octet-stream; name="bi_recs_map.patch.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0204301321470.3469@hill.cs.ucr.edu>
Content-Description: 
Content-Disposition: attachment; filename="bi_recs_map.patch.gz"

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
--394922409-354102991-1020198107=:3469--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
