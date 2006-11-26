Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 655FE67BE1
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 06:21:56 +1100 (EST)
Date: Sun, 26 Nov 2006 20:21:48 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Re: NTP time sync
Message-ID: <20061126202148.190d5b4b@inspiron>
In-Reply-To: <009a01c7114a$b429f850$020120ac@Jocke>
References: <200611251522.19900.david-b@pacbell.net>
	<009a01c7114a$b429f850$020120ac@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, 'Andi Kleen' <ak@muc.de>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, 'David Brownell' <david-b@pacbell.net>,
	linuxppc-dev@ozlabs.org, lethal@linux-sh.org, paulus@samba.org,
	kkojima@rr.iij4u.or.jp, davem@davemloft.net, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 26 Nov 2006 12:04:54 +0100
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> Looking at rtc-dev.c I don't see a MARJOR number assigned to /dev/rtcN. Seems like
> it is dynamically allocated to whatever major number that is free.
> Is that the way it is supposed to be? How do I create a static /dev/rtcN in my /dev
> directory if the major number isn't fixed?
> Maybe I am just missing something, feel free to correct me :)

 udev ;)

 the concept of static numbers is quite old...

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
