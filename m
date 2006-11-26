Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 9210F67BDD
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 09:53:24 +1100 (EST)
Date: Sun, 26 Nov 2006 23:53:17 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Re: NTP time sync
Message-ID: <20061126235317.5d40d22c@inspiron>
In-Reply-To: <00b301c711a3$07cf3530$020120ac@Jocke>
References: <20061126202148.190d5b4b@inspiron>
	<00b301c711a3$07cf3530$020120ac@Jocke>
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

On Sun, 26 Nov 2006 22:37:10 +0100
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> >  the concept of static numbers is quite old...
> 
> Yes it is old, but is the old way unsupported now? I have an embedded target
> which is using the old static /dev directory, do I need to make
> it udev aware to use newer features like the rtc subsystem?

 That can be a good option. You can also do
 a symlink to /dev/rtc0 in your boot scripts or simply
 upgrade your hwclock to a version that accepts
 the device as a parameter.

 The old /dev/rtc name is not supported on the new rtc subsystem.

 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
