Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC0D52BDA2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 02:04:57 +1000 (EST)
In-Reply-To: <20041013144909.388.qmail@web53808.mail.yahoo.com>
References: <20041013144909.388.qmail@web53808.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EB774D3A-1D31-11D9-B966-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 13 Oct 2004 12:07:02 -0400
To: annamaya <annamaya@yahoo.com>
Cc: Sam Song <samlinuxppc@yahoo.com.cn>, linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 13, 2004, at 10:49 AM, annamaya wrote:

> ..... But my driver doesn't work and complains
> about a TX timeout. I am sure I am missing something.
> Can you suggest something that I could try?

You are going to have to track down the clock and
control signals for the FCC and make sure they are
still connected the same way as the 8260.  Sounds
like they aren't.  There are #defines at the top of the
driver file that map the GPIO pins to the FCC signals.


	-- Dan
