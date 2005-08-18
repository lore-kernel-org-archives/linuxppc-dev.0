Return-Path: <solca@guug.org>
Received: from guug.org (guug.org [168.234.203.30])
	by ozlabs.org (Postfix) with ESMTP id 3A0DB68004
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 10:18:49 +1000 (EST)
Date: Wed, 17 Aug 2005 18:02:09 -0600
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050818000209.GA2389@guug.org>
References: <20050812032819.GA4763@guug.org> <20050815222510.C28706@cox.net>
	<20050816211259.GB28419@guug.org> <20050816141908.A1053@cox.net>
	<20050817024745.GA30824@guug.org> <20050816201745.C2246@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050816201745.C2246@cox.net>
From: Otto Solares <solca@guug.org>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Redwood-6 and 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 16, 2005 at 08:17:45PM -0700, Matt Porter wrote:
> What kernel port are you using?  You're trying boot a Redwood 6
> kernel on the MediaMVP?

I'm using kernel.org's 2.6.12.4 + your dma patch.

Yes I'm trying to boot this redwood6 kernel on the MediaMVP,
Hauppauge provides source for 2.4.18 which is plain old, my
University project is boot a 2.6 kernel on this little box.

I setup netconsole to see what's going on in the boot but
it doesn't work that's why I think the smc91x driver does not
support PPC or probably it does not support netpoll which is
the base for netconsole, I'll continue figuring out what is
going on.

I really apreciate all your help.  Thank you.

-otto
