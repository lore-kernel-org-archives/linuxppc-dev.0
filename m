From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Why isn't there an validate_dcache_range() function?
Date: Mon, 28 Oct 2002 16:38:44 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJOEHFCKAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I just got stuck with that question and shurely whoun't find the answer:
If I am using invalidate_dcache_range() for the data area of an skb
shouldn't I enable caching for that area after the the skb is no longer
assigned to the CPM module? There's no validate_dchace_range() so I can't.
Why?
There's shurely a reason for that. But I think using an skb like this will
disable caching for most of the memory areas in a long term view...
Is there any solution?

Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
