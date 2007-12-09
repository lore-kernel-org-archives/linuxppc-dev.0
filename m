Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 426A7DDEDE
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 07:34:16 +1100 (EST)
Date: Sun, 9 Dec 2007 14:39:03 -0600
From: Olof Johansson <olof@lixom.net>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
Message-ID: <20071209203903.GB26651@lixom.net>
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 09, 2007 at 03:24:55PM -0500, Jon Smirl wrote:
> What is the status of this series, is there anything I can do to help
> get this into the i2c subsystem?

I never saw the comments about whitespace cleanups being addressed. If
you run them through checkpatch you'll see quite a few things that needs
fixups. Care to do the round of cleanups and repost the series?

Besides that I'm fine with the approach of moving the matching to the
i2c layer, it does seem like a reasonable thing to do.


-Olof
