Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4872679FF
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 08:29:46 +1100 (EST)
Subject: Re: copying /sys causes fans to spin up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060227160911.GA17569@suse.de>
References: <20060227160911.GA17569@suse.de>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 08:29:55 +1100
Message-Id: <1141075795.4809.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-02-27 at 17:09 +0100, Olaf Hering wrote:
> Ben, 
> 
> 
> some tool copies /sys, and while doing it, the fans start to spin up on
> my G5. Any idea how to fix it, other than not reading from /sys? Have to
> find the exact file.

Interesting... it's causing the i2c bus to go nuts... It would be useful
to find out what file indeed...

Ben.
