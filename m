Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E655A2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 07:24:18 +1000 (EST)
In-Reply-To: <20041012210259.3831.qmail@web53807.mail.yahoo.com>
References: <20041012210259.3831.qmail@web53807.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <61D85700-1C95-11D9-91B5-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 12 Oct 2004 17:26:30 -0400
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


On Oct 12, 2004, at 5:02 PM, annamaya wrote:

> I am now trying to do an NFS mount of the root file
> system. Looks like the EP8280 uses LXT971A PHY device.

I have one of their first 8260 boards that I used to do
the initial Linux port long ago.  At that time, they had
some weird CPLD implementation of MDIO that I could
never get to work properly.  Not a bad idea, just didn't
seem to be implemented properly.  I know they have
done a second revision of this board, and I suspect
the 8280 is just a glue into the same location design.

With that board you should have received sufficient
information to determine what to do, although they
have always been quite secretive about releasing
enough information to successfully write software.

In the interim, just compile the driver without any
MDIO control, hack the call to fcc_restart() at the
end of init_fcc_startup() to just force half or full
duplex (0 or 1) based upon the switch you are using.


Good Luck.


	-- Dan
