Date: Thu, 30 Dec 1999 10:41:02 -0800
From: David Hinds <dhinds@valinux.com>
To: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
Cc: dhinds@sourceforge.org,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        phr-pcmcia@nightsong.com, nknack@vikingcomponents.com
Subject: Re: CompactFlash Viking problem
Message-ID: <19991230104102.E30321@valinux.com>
References: <386B5437.86F7449B@switchboard.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <386B5437.86F7449B@switchboard.ericsson.se>; from Magnus Damm on Thu, Dec 30, 1999 at 01:46:47PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 30, 1999 at 01:46:47PM +0100, Magnus Damm wrote:
> 
> My code reads the attribute space on each card
> and parses the tuples. The problem is that the
> Viking card gives me correct CIS sometimes,
> but mostly crap (I guess some kind of test-pattern).
> This leads to no end-of-cis marker, which is bad.

It's possible that the card is reporting "ready" too early, before the
CIS is actually readable.  You might try working around the problem by
increasing the delays in the power-up sequence.

-- Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
