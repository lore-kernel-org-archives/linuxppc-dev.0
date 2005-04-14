Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E7D667A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 22:01:59 +1000 (EST)
In-Reply-To: <200504140926.01775.Schramel.Linux@go.bartec.de>
References: <200504140926.01775.Schramel.Linux@go.bartec.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a06218f5ec69af94cf7d5f7616eed028@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 14 Apr 2005 08:01:47 -0400
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


On Apr 14, 2005, at 3:26 AM, Marco Schramel wrote:

> During booting kernel hangs on initializing ttyS2 forever.

That is the console port, so take a look at the code for its
initialization for something affected by this configuration.
What kernel are you using?  There have been lots of
updates in recent versions.

> What could be wrong ? I only changed the io port configuration in the 
> init function.

Heh :-)  There are lots of permutations of serial ports that probably
haven't been tested.  You probably found one of them.

Thanks.


	-- Dan
