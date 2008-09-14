Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809141625u3cd94e7jf05584031be7c1d9@mail.gmail.com>
Date: Sun, 14 Sep 2008 19:25:26 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: demuxing irqs
In-Reply-To: <9e4733910809140706i599d70b2q12d3582c7a95498c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809131206j125e7e25of07c19028ac07339@mail.gmail.com>
	<adaprn7is80.fsf@cisco.com>
	<9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com>
	<adaljxvir57.fsf@cisco.com>
	<9e4733910809131623pe990495l96b31bd546d9fa6b@mail.gmail.com>
	<9e4733910809140706i599d70b2q12d3582c7a95498c@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm making some progress on this. I implemented gpio_to_irq() and
irq_to_gpio() to cause a 1:1 mapping.

Currently my irqhost->match() function is never getting called with my
device tree node so I need to figure out why. Without matching my
irqhost->map() function doesn't get called.

-- 
Jon Smirl
jonsmirl@gmail.com
