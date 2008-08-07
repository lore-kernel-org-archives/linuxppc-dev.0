Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FEE5DDF3C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 23:19:35 +1000 (EST)
Message-Id: <A4CCB071-0FCE-490A-B563-399FCA74C71E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200808071448.06183.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: Fix Book-E watchdog timer interval setting
Date: Thu, 7 Aug 2008 08:19:10 -0500
References: <200808071448.06183.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 7, 2008, at 7:48 AM, Matthias Fuchs wrote:

> This patch fixes the setting of the Book-E watchdog timer interval  
> setup
> on initialization and by ioctl().
>
> Tested on PPC440EPx sequoia evaluation board.
>
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
> ---
> drivers/watchdog/booke_wdt.c |    6 +++++-
> 1 files changed, 5 insertions(+), 1 deletions(-)

can you be more explicit about what the bug was.

- k
