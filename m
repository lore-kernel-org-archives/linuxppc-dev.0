Return-Path: <SRS0+1020516fb0ec803710a0+1314+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Implement check_legacy_ioport() on PS3
From: David Woodhouse <dwmw2@infradead.org>
To: michael@ellerman.id.au
In-Reply-To: <1175219000.5241.6.camel@concordia.ozlabs.ibm.com>
References: <1175212972.3122.87.camel@pmac.infradead.org>
	<20070330014542.GA28342@lixom.net>
	<1175219000.5241.6.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 02:49:59 +0100
Message-Id: <1175219399.3122.109.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-30 at 11:43 +1000, Michael Ellerman wrote:
> No I just looked at it too. We have 19 platforms, 7 define
> check_legacy_ioport(), 6 of those return ENODEV, one does something
> useful. Which leaves 12 platforms that get the default "return 0"
> behaviour.
> 
> I still don't like it though, having to opt _out_ of random io port
> poking is not nice. 

Of those 12 platforms which get the default behaviour, how many of them
_want_ it? And how many, like PS3, are buggy?

-- 
dwmw2
