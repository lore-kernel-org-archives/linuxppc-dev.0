Subject: Re: new ATI sleep code freezes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mutex@kerneli.org
Cc: Michel D?nzer <michel@daenzer.net>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030604162837.GF1982@heliosphan>
References: <20030529154143.GC7896@heliosphan>
	 <1054496170.25677.28.camel@thor.holligenstrasse29.lan>
	 <20030604162837.GF1982@heliosphan>
Content-Type: text/plain
Message-Id: <1054746955.696.7.camel@gaston>
Mime-Version: 1.0
Date: 04 Jun 2003 19:15:55 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Also make sure you have APM emulation working (check XFree log to see if it found & opened the APM device)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
