From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	<linuxppc-dev@lists.linuxppc.org>, Daniel Berlin <dan@cgsoftware.com>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Fri, 16 Nov 2001 14:47:48 +0100
Message-Id: <20011116134748.24979@smtp.adsl.oleane.com>
In-Reply-To: <20011116125743.SSEO9849.tomts10-srv.bellnexxia.net@there>
References: <20011116125743.SSEO9849.tomts10-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi Daniel,
>
>I looked at the EDID info for my normal Apple 17" multisync monitor and
>when I look at the detailed timing section the timings provided are not
>"good" to day the least.
>
>        Mode    "832x624"       # vfreq 74.546Hz, hfreq 49.722kHz
>        Mode    "1600x1200"     # vfreq 59.944Hz, hfreq 74.931kHz
>
>The 75hz 832x624 size seems strange to me and the 60 hz 1600x1200 would
>just be a terrible refresh rate.

The 832x624 timing is a common "Apple" timing. The 1600x1200 is probably
just the maximum supported, don't you think ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
