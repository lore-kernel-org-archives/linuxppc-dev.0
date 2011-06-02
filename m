Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id 8A486B6F9A
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2011 16:27:56 +1000 (EST)
Date: Wed, 1 Jun 2011 23:20:55 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: Re: [RFT][PATCH 3.0] ssb: fix PCI(e) driver regression causing oops
	on PCI cards
In-Reply-To: <BANLkTi=mbBiSOGbEZ4AEYqZgyvgW0oXKtw@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1106012317230.21697@trent.utfs.org>
References: <1306918871-16965-1-git-send-email-zajec5@gmail.com>
	<BANLkTinSdDZv7gshYfi4mK5N9K-E7vk3Yw@mail.gmail.com>
	<BANLkTi=mbBiSOGbEZ4AEYqZgyvgW0oXKtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linux-wireless@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andreas Schwab <schwab@linux-m68k.org>, b43-dev@lists.infradead.org,
	=?UTF-8?Q?Michael_B=C3=BCsch?= <mb@bu3sch.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Jun 2011 at 08:13, Rafał Miłecki wrote:
> John, I'm afraid more and more people get angry at me because of this ;)

Erm, I'm not angry at anyone :-) On the contrary, I'm happy about the fix 
so quickly available!

Though I'm a bit afraid of the next git bisect session, as it might not be 
so straightforward than this one...

Thanks to all involved,
Christian.
-- 
BOFH excuse #230:

Lusers learning curve appears to be fractal
