Subject: Re: [RFC] Re: BestComm and fec
From: David Woodhouse <dwmw2@infradead.org>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Sylvain Munaut <tnt@246tnt.com>,
	Gabor Janak <g.janak@unicontrol.de>,
	linuxppc-embedded@lists.linuxppc.org, Wolfgang Denk <wd@denx.de>
In-Reply-To: <149461203.20040824120707@varma-el.com>
References: <412A4B69.7000305@246tNt.com>
	 <149461203.20040824120707@varma-el.com>
Content-Type: text/plain
Message-Id: <1093337686.3777.755.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 09:54:46 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-08-24 at 12:07 +0400, Andrey Volkov wrote:
> Terrible, may be its time to create special project for MPC5200 (if it
> doesn't exist in somewhere in I-net)? First intention - sourceforge.
> Comments/suggestions?

Don't start a new project. Just put your changes into the official 2.6
tree.

The goal of _all_ external trees should be to make themselves obsolete
by getting all changes to Linus as quickly as possible. Why shoot
yourself in the foot?

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
