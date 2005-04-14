Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D29DC67B3A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 01:51:52 +1000 (EST)
In-Reply-To: <200504141454.03704.Schramel.Linux@go.bartec.de>
References: <200504140926.01775.Schramel.Linux@go.bartec.de>
	<a06218f5ec69af94cf7d5f7616eed028@embeddededge.com>
	<200504141454.03704.Schramel.Linux@go.bartec.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c8e8aeb6fa88fbff91b96fc5ab92e61e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 14 Apr 2005 11:51:45 -0400
To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: CPM uart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 14, 2005, at 8:54 AM, Marco Schramel wrote:

> I use kernel version 2.4.25 of denx and the uart version is
> static char *serial_name = "CPM UART driver";
> static char *serial_version = "0.01";

I don't remember the progress of the new cpm serial drivers in 2.4,
I've been spending too much time in 2.6.  If you find a 2.4 kernel
with the new serial driver model (drivers/seral/cpm_uart) that
would be a big help.

> Are there newer versions? Sorry, but i am not up to date with the uart.
> Is my configuration so extraordinary ;-) ?

Yes, there are newer versions and I've never tried what you are
doing.  The console code has always been sensitive to configurations.
Although the #defines may look like it will work, the code often isn't
there to support it, and I know wasn't there in that old version of the 
code.

Thanks.

	-- Dan
