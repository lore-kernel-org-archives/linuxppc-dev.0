Message-ID: <410543CA.2080706@mvista.com>
Date: Mon, 26 Jul 2004 10:47:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: sjhill@realitydiluted.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64360 serial driver for 2.6....
References: <E1Bp491-0000SM-00@real.realitydiluted.com>
In-Reply-To: <E1Bp491-0000SM-00@real.realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sjhill@realitydiluted.com wrote:

>Greetings.
>
>I see that a few people are working with the 64x60 chips
>from Marvell. Has anyone ported the serial driver from 2.4
>into 2.6 yet? I have the 2.4 code and have ported the
>serial console code to 2.6 just fine, but I would rather
>not waste my time porting the serial driver proper if
>someone else has done it already. Please CC: me on the
>reply as I cannot subscribe to any of the PPC lists, even
>after multiple attempts.
>
>

Steve,

bk://source.mvista.com/linux-2.5-marvell is the current working tree for
Marvell 64x60 devices in 2.6.  There is a new mpsc driver that fits
under the new 2.6 serial infrastructure.  Its new and still has some
problems but you should at least be able to use the console.  So far,
only the ev64260 platform uses it.  You should take a look at that code
to see what you need to do to get it to work on your platform.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
