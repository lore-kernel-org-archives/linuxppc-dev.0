Message-ID: <003501c4582b$93efa290$2700000a@jmartin>
From: "jmartin" <jmartin@prodys.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: idma problems
Date: Tue, 22 Jun 2004 09:36:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi again,

    i'm studing idma problems on mpc8xx. When i active idma i lost console.
machine registers show:

    TESR     0x00002010 (it means instruction fetch externally terminated by
TEA)
    SDSR     shows     0x80
    SDAR    shows     A8A21111

machine hang. Any ideas?
thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
