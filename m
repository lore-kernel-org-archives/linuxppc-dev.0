From: Dave Pegler <dwp@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14976.13620.587588.692077@gargle.gargle.HOWL>
Date: Tue, 6 Feb 2001 17:32:36 +0000 (GMT)
To: Mark Clayton <clayton@shore.net>
Cc: linuxppc-embedded@lists.linuxppc.org, dwp@cambridgebroadband.com
Subject: ATM driver for 8260
In-Reply-To: <200102061511.KAA17221@northshore.shore.net>
References: <200102061511.KAA17221@northshore.shore.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark,

   I've been working on a driver for the MPC860SAR (855T / 857 /
862SAR). It supports AAL0, AAL5, CBR and UBR and is integrated into
linux ATM version 0.59 (so you get Q.2931, RFC1577, ILMI etc). I use
a FADS 860 with a SAR-PHY daughter card (STM-1/STS-3c, E1/T1 and
ATM25) as the development platform.

Unfortunately its not finished yet and has quite a low throughput. I've not
worked on it for about 3 months but hope to do so in the next few weeks.

Dave.

Mark Clayton writes:
 >
 > Is anyone aware of a linux driver for the ADS8260.  Or any 8260?
 >
 > Thanks,
 > Mark
 >
 >

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
