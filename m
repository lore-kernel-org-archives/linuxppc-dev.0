Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1B7782BF16
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 10:42:59 +1100 (EST)
Date: Wed, 12 Jan 2005 15:42:56 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Goforth, Edward" <Ed.Goforth@gd-ais.com>
Message-ID: <20050112234256.GA26091@gate.ebshome.net>
References: <9A48EF7239039B48834A3F6B644B0C71EF8679@vaff06-mail01.ad.gd-ais.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9A48EF7239039B48834A3F6B644B0C71EF8679@vaff06-mail01.ad.gd-ais.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: board with no RTC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 12, 2005 at 06:25:45PM -0500, Goforth, Edward wrote:
> We have a 440gx based custom board.  I have learned that it does not
> have a RTC. Has anyone had any success with a board without a RTC, or is
> it even possible?  How much of a problem will this cause?  
> 

There shouldn't be any problems without RTC except the fact that you 
need to worry about getting correct time.

I have many 4xx-based boards without RTC. They "just work".

--
Eugene
