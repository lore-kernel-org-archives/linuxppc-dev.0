From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>,
	Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Troy Benjegerdes'" <hozer@drgw.net>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'Paul Mackerras'" <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
Date: Fri, 10 May 2002 23:16:49 +0200
Message-Id: <20020510211649.18120@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0205101659590.23021-100000@gra-lx1.iram.es>
References: <Pine.LNX.4.33.0205101659590.23021-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I don't have the time to study whether the patches proposed would work
>well in all these weird cases.
>
>BTW, how do you initially set the system time in your RTC less machines ?

I spent some time studying the latest of the patches and it seems ok.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
