Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0E343DDEBE
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 04:30:04 +1100 (EST)
Date: Tue, 27 Nov 2007 20:34:56 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata
	nodes
Message-ID: <20071127173456.GA15693@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153940.GC14183@localhost.localdomain>
	<474C3C79.5060908@ru.mvista.com>
	<20071127164101.GA14790@localhost.localdomain>
	<474C49D5.2000206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <474C49D5.2000206@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[ Had cut too much in the previous reply ]

On Tue, Nov 27, 2007 at 07:46:13PM +0300, Sergei Shtylyov wrote:
[...]
> >2. "ioport" because shift^Wstride ;-) applies only to the io range
> >   (yes, it's obvious, but worth open-wording, no?).
> 
>    Contrarywise, to memory range.

By io range I meant "I/O base", in contrast to "CTL base".

There is no need to apply shifting for CTL. That's why ioport-*
appeared in the first place.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
