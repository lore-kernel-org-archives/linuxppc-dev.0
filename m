Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [204.133.123.27])
	by ozlabs.org (Postfix) with ESMTP id C16D1DE0F1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 07:39:20 +1000 (EST)
Message-ID: <48BDB284.1070603@mlbassoc.com>
Date: Tue, 02 Sep 2008 15:39:16 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Initialization order
References: <48BDAFF3.2090803@mlbassoc.com>
	<20080902213312.GA18146@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080902213312.GA18146@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Tue, Sep 02, 2008 at 03:28:19PM -0600, Gary Thomas wrote:
>> I'm working with a couple FreeScale platforms and having
>> trouble getting the RTC which is connected via I2C to work.
>> I had this working fine in the old arch/ppc tree, but it's
>> failing in the arch/powerpc world.
> 
> Make sure the rtc chip is described in the device tree (search existing
> trees for rtc@ for examples).

That did it, thanks :-)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
