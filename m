Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F7E32BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 05:16:18 +1000 (EST)
In-Reply-To: <20041008180209.GD14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<20041008164047.GC14773@smtp.west.cox.net>
	<944792EE-194E-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008180209.GD14773@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7079964C-1959-11D9-9299-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Oct 2004 14:39:51 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 8, 2004, at 2:02 PM, Tom Rini wrote:

> But that's what I just described.  Letting the special config options
> (I don't know if I'd call 85xx_PCI2 "I/O", but it is special) live in
> platforms/8xx/Kconfig (or ppc/Kconfig.cpm1, or whatever).

You are conveniently ignoring the 4xx serial port configuration
options that live in the platforms/4xx/Kconfig right now.  Taking
debating lessons from dubyah, I guess :-)  It is more likely we
will see additions to the existing 85xx/Kconfig as it matures
like are needed for 8xx.  You will have to add the configuration
options I mentioned in previous messages, so you may as
well prepare for that now.

If you need change for the sake of change or just because you
want to disagree with me, then there isn't anything I can do to
convince you otherwise.  There is precedent from previous
releases, in the current release with other processors, and from
extensive experience that you should make you consider my
suggestions.  I can understand moving the sources to better
assist the development of code that interacts with these drivers,
but scattering the unique and interdependent configuration
options around isn't helpful.  The non-ppc folks updating the
generic Kconfig files are going to be totally confused by that.

Thanks.


	-- Dan
