Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DE52DDE48
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 07:49:33 +1100 (EST)
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 07:46:48 +1100
Message-Id: <1197233208.6563.14.camel@pasglop>
Mime-Version: 1.0
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-12-09 at 15:24 -0500, Jon Smirl wrote:
> What is the status of this series, is there anything I can do to help
> get this into the i2c subsystem?

I think there were a few comments such as whitespace issues and Scott
had a comment about a tag to differenciate matching type.

Thus the expectation is that you'll respin the serie with those
addressed.

Ben.
