Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: WRITE_THRU  on 8xx missing
Date: Wed, 4 Sep 2002 15:20:33 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLGECHFGAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <3D6DB30E.6060509@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to create a cached memory mapping which is in WRITETHRU using ioremap().
But in the latest PPC kernel for a mpc8xx target there is no flag for WRITETHRU (_PAGE_WRITETHRU).

Why is it gone? Is there a replacement flag?
I want to use this mapping to do burst reads but single writes for a flash device.

 Joakim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
