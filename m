Date: Wed, 15 Sep 1999 13:57:12 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: More OF booting
Message-Id: <19990915135712.011244@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Another thing I discovered recently is that there is an update for the
firmware of Apple's Symbios 53C875 SCSI board that used to be shipped
with Beige G3s. This update makes it OF compatible and is part of the
MacOS X Server installation.

Currently, I think there is no other way to update the board, you have to
launch MacOS X Server installer, it's apparently not included in Darwin's
installer and is not available as a separate tool.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
