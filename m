In-Reply-To: <19990910161322.A1674@them.org>
Date: Sat, 11 Sep 1999 11:23:23 +0200
To: Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
Message-Id: <19990911112323.032168@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I have a bunch of information on this lying around, and most of my
>other kernel problems seem to be resolved now.  I'm in the process of
>upgrading to current vger; if it succeeds, I'll try to merge all
>pending controlfb stuff tomorrow.

I also have a pair of crazy 8500 who have 2Mb of VRAM but in bank2 (they
don't work if the VRAM is moved to bank1, even under MacOS). The current
controlfb appears to work well. Send me your merge results, I'll test on
one of those weird machines Monday.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
