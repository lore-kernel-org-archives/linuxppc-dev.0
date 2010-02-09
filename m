Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 5AD14B7D6B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 06:06:01 +1100 (EST)
Date: Tue, 9 Feb 2010 22:06:00 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Michal Simek <michal.simek@petalogix.com>
Subject: Re: [PATCH RFC 0/3] Implement refcounting for OF GPIO chips
Message-ID: <20100209190600.GA26668@oksana.dev.rtsoft.ru>
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
	<4B712DA5.4000802@petalogix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4B712DA5.4000802@petalogix.com>
Cc: Michal Simek <monstr@monstr.eu>,
	David Brownell <dbrownell@users.sourceforge.net>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 09, 2010 at 10:40:53AM +0100, Michal Simek wrote:
[...]
> >The above situation is hard to trigger, but the issue is there
> >nonetheless, and so needs fixing.
> 
> 
> I tested xilinx gpio driver, heartbeat trigger and access through
> sysfs and I haven't found any problem. There is only small part of
> code for Microblaze and it is the same with PowerPC. If is Ben OK
> with it, I am ok too.

Thanks for testing!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
