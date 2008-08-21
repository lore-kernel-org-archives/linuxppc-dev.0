Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id AB826DFBC4
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:58:44 +1000 (EST)
Date: Thu, 21 Aug 2008 14:58:42 -0700 (PDT)
Message-Id: <20080821.145842.140799897.davem@davemloft.net>
To: jonsmirl@gmail.com
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <9e4733910808211453t63f0a6f5h2139e027319263f1@mail.gmail.com>
References: <20080821.001012.265401427.davem@davemloft.net>
	<9e4733910808211453t63f0a6f5h2139e027319263f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Jon Smirl" <jonsmirl@gmail.com>
Date: Thu, 21 Aug 2008 17:53:02 -0400

> >  2) When CONFIG_SPARC, shift the device address down by one bit before
> >    giving it to the Linux I2C layer.
> 
> How do you deal with a 10-bit address i2c device? Is it multiplied by two too?

Yes.
