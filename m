Return-Path: <david-b@pacbell.net>
Received: from n78.bullet.mail.sp1.yahoo.com (n78.bullet.mail.sp1.yahoo.com
	[98.136.44.42]) by ozlabs.org (Postfix) with SMTP id 2E617B6F11
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 04:46:27 +1000 (EST)
Message-ID: <254168.47917.qm@web180307.mail.gq1.yahoo.com>
Date: Fri, 30 Jul 2010 11:46:24 -0700 (PDT)
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
To: =?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?= <m.nazarewicz@samsung.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
In-Reply-To: <20100730152602.GA28042@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Cliff Cai <cliff.cai@analog.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>, Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Julia Lawall <julia@diku.dk>, Philipp Zabel <philipp.zabel@gmail.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Felipe Balbi <felipe.balbi@nokia.com>,
	Andrea Gelmini <andrea.gelmini@gelma.net>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Fabien Chouteau <fabien.chouteau@barco.com>,
	Dan Carpenter <error27@gmail.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Vladimir Zapolskiy <vzapolskiy@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Vincent Sanders <support@simtec.co.uk>, Marc Singer <elf@buici.com>,
	=?utf-8?B?QW5kcsOpIEdvZGRhcmQgUm9zYQ==?= <andre.goddard@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Tobias Klauser <tklauser@distanz.ch>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>,
	Eirik Aanonsen <eaa@wprmedical.com>, Mike Frysinger <vapier@gentoo.org>,
	Thomas Dahlmann <dahlmann.thomas@arcor.de>,
	linux-geode@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	Magnus Damm <damm@igel.co.jp>, Anton Vorontsov <avorontsov@ru.mvista.com>,
	Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org,
	Anatolij Gustschin <agust@denx.de>, Eric Miao <eric.y.miao@gmail.com>,
	=?utf-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>,
	Jiri Kosina <jkosina@suse.cz>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-usb@vger.kernel.org, Harro Haan <hrhaan@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cory Maccarrone <darkstar6262@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A> - The bind functions are only called at init time, so there=0A> is no =
need=0A> =C2=A0 to save a pointer to it.=0A=0ARight.  Let's retain the spac=
e-saving behaviors=0Aby keeping init-only code in init sections.=0A=0A- Dav=
e=0A
