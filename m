From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 - buttons, temperature, ictc
Date: Tue, 17 Jul 2001 12:19:01 +0200
Message-Id: <20010717101901.21603@smtp.adsl.oleane.com>
In-Reply-To: <5.1.0.14.2.20010717110248.03890268@mail.netsurf.de>
References: <5.1.0.14.2.20010717110248.03890268@mail.netsurf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I object to putting anything you marked with CONFIG_PMAC_VOLUME into the
>kernel, it's worse enough we have CONFIG_PMAC_BACKLIGHT in there. I'll
>merge your "input_report_key" into my 2.5 adbhid.c source though, thx.
>
>With 2.5 even CONFIG_PMAC_BACKLIGHT in adbhid.c will go away and you _have_
>to use the event devices then, so you better start using them _now_. Taking
>kernel bloating shortcuts is not the way to go IMHO.

Right, all this belongs to userland. I might include part of this
patch in 2.4 so we have the feature working now, but for 2.5, I'd
rather use the event devices for both backlight and volume, and
have pmud handle them.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
