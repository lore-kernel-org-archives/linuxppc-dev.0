Date: Tue, 20 Aug 2002 07:38:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 rsync tree broken
Message-ID: <20020820143837.GA891@opus.bloom.county>
References: <20020819200140.A9590@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020819200140.A9590@sunbeam.de.gnumonks.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 19, 2002 at 08:01:40PM +0200, Harald Welte wrote:

> The current (at least yesterday and today) linuxppc-2.5 tree at
> source.mvista.com is broken.
>
> It is totally missing the directories sound/core and drivers/usb/core.

What flags are you passing to rsync?  Both of those directories exist in
the tree rsync serves from.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
