From: Joe Green <jgreen@mvista.com>
To: "John F. Davis" <davis@skink.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ramdisk size using montevista
Date: Wed, 21 Mar 2001 15:00:57 -0800
Content-Type: text/plain
References: <20010321175758.A7228@skink.net>
In-Reply-To: <20010321175758.A7228@skink.net>
MIME-Version: 1.0
Message-Id: <01032115021500.03855@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John F. Davis wrote:
> I am trying to boot hardhat linux with a small ram disk.  However, libc is more
> than 4 megs by itself.  Is there something obvious I can do/read?

Strip the library.  It will remove symbols that are handy for
debugging, but leave the ones that are needed for dynamic linking.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
