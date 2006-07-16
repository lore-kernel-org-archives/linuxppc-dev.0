Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9549167B8A
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 05:26:19 +1000 (EST)
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <1153077550.5905.33.camel@localhost.localdomain>
References: <20060716163728.GA16228@suse.de> <20060716165004.GA16369@suse.de>
	<1153077550.5905.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 15:25:53 -0400
Message-Id: <1153077953.5905.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yeah, that looks like some serious bogosity in that code. Care to send a
> patch ?

(I'm in a hotel room in Ottawa with no r128 at hand to test so I'm not
doing it myself just now :)

Ben.
