In-Reply-To: <Pine.LNX.4.44.0408271130100.16734-100000@linpc003.aimsys.nl>
References: <Pine.LNX.4.44.0408271130100.16734-100000@linpc003.aimsys.nl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CE15CB43-F838-11D8-BF10-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: ushort fcc_fcce
Date: Fri, 27 Aug 2004 10:53:06 -0400
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 27, 2004, at 5:31 AM, Jaap-Jan Boor wrote:

> Why is
> include/asm-ppc/immap_8260.h:   ushort  fcc_fcce;

Because in the original documentation I had under NDA
many years ago when this was written didn't describe
ATM nor HDLC.  It listed this as a 16-bit field for Ethernet.

I've made a note to change it.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
