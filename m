In-Reply-To: <19990921161556.026124>
Date: Tue, 21 Sep 1999 16:20:44 +0200
To: ostermann@cs.ohiou.edu
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PB3400 ethernet and Q1->Q3 upgrade
Message-Id: <19990921162044.003557@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Humm... even weirder: Apple's code seems to set the base address of
ohare2 to the same base address as ohare. So either there's a second chip
cascaded there, or there's not and in this case, the eth interrupt is bit 28.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
