Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C0E76DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 21:38:31 +1000 (EST)
Date: Tue, 28 Apr 2009 04:38:23 -0700 (PDT)
Message-Id: <20090428.043823.244762395.davem@davemloft.net>
To: leoli@freescale.com
Subject: Re: [PATCH] rio: warn_unused_result warnings fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <2a27d3730904280408j636d8e4tc1b6e1c827509379@mail.gmail.com>
References: <1240913737-23773-5-git-send-email-leoli@freescale.com>
	<1240915882.15414.3.camel@localhost>
	<2a27d3730904280408j636d8e4tc1b6e1c827509379@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>
Date: Tue, 28 Apr 2009 19:08:13 +0800

> IMHO, when device_add() fails the system is quite broken.  So the
> value is very limited for it to fail cleanly, which need some effort
> to implement.  I can add it if you insist.

I disagree.

For the cases where device_add() fails (duplicate name, for
example) the device layer already is emitting warnings.

You're just adding more log messages for the user to sift
through, and likely not adding any new information.
