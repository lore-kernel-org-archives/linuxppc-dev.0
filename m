Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>,
	Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Help from Gurus on modes and timing and frame buffers needed!
Date: Fri, 9 Nov 2001 08:23:47 -0500
References: <v04003a0eb8110c4666ff@[24.70.162.28]>
In-Reply-To: <v04003a0eb8110c4666ff@[24.70.162.28]>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <20011109132150.FHFJ13234.tomts8-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tony and Roman,

Thanks for your help with this!  The drawing and formulas helped me
understand things.  When I add to that nomenclature the nomenclature used
by the specific graphic card docs, things can get very confusing.  It
seems the VCLK and the DOT_CLOCK, and the PIXEL_CLOCK are all related but
they are ofter scaled differently (off by a factor of 10) and given as
inverses or one or the other.  Very confusing!

Anyway  One last question:

How are the Sync Flags determined?  I assume they either tell you if the
sync is an upward pulse or a downward pulse,  or which edge to trigger on
or something like that.

I see in the EDID block that SYNC_T = 1 but I have no idea how

                Flags   "-HSync" "-VSync"

are determined from that (or anything else).

Again any help would be greatly appreciated here.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
