Date: Wed, 18 Jul 2001 22:13:08 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: Bastien Nocera <hadess@hadess.net>, <iain@sandoe.co.uk>,
	<benh@kernel.crashing.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 - buttons, temperature, ictc
In-Reply-To: <20010718130000.7cc04c7a.jpgarcia@execpc.com>
Message-ID: <Pine.LNX.4.33.0107182212440.2441-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Bastien Nocera <hadess@hadess.net> wrote:
> > Why would pmud make sense for the backlight ? because changing the
> > backlight settings saves power ? ..Right.
>
> I suppose if we wanted a userspace interface to the backlight, would
> ioctls on the /dev/fb# be an adequate solution.  Since the display

We already have (fbset).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
