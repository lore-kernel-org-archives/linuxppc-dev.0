From: "Kevin P. Dankwardt" <k@kcomputing.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Fast boot times
Date: Mon, 7 Jun 2004 20:57:25 -0500
Message-ID: <KCEOLLHGFJIAFNAMGACHIEGADMAA.k@kcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20040604161515.C28C6C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am participating in a project that has a challenging boot time
requirement. We need a Linux boot solution where we have booted in the
50msec range, talking on a protocol stack, from a COLD Start (power being
applied to the board.) The loading of the drivers and the stack
initialization has to occur within 50msec.

Does anyone have any leads/ideas for being able to meet this deadline?

Thanks,
Kevin Dankwardt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
