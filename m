Message-ID: <013101c1cf69$946139c0$5ad58a89@cern.ch>
From: "Pei-Jie Hong" <Pei-Jie.Hong@cern.ch>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <A1C99F4731CAD111BA5400A024FC3B0CBE06EA@ESBILMA01EDCGE>
Subject: JFFS2 question!
Date: Tue, 19 Mar 2002 18:14:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    We have our own PPC750 board with 4 8MB(16 bits, sector size 64k byte)
AMD Flash chips on it. Currently we only use on chip, and try to make JFFS2
filesystem on it. We did pretty well on it.
    However, we have a question. When we try to copy a small file into the
Flash
memory, it always resides at the beginning of the last sector of the flash
memory.
Does that mean JFFS2 grow backward?
    Thanks.

Best regards,
Pei-Jie Hong


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
