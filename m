Return-Path: <m_123456_h@hotmail.com>
Received: from BAY0-OMC3-S10.bay0.hotmail.com (bay0-omc3-s10.bay0.hotmail.com
	[65.54.246.210]) by ozlabs.org (Postfix) with ESMTP id C070ADDECF
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Feb 2007 10:31:47 +1100 (EST)
Message-ID: <BAY116-F157EB542041BF42BB53FE8CD990@phx.gbl>
From: "Jack Ger" <m_123456_h@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem with linking customer phy with fs_enet drivers 
Date: Sun, 04 Feb 2007 15:19:41 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I am trying to run the customer LXT970 phy with MPC870, porting from
MPC885.  I have the lxt phy driver installed and fs_enet driver installed 
during
the kernel bootup.  But during the the fs_enet_open, when trying to link
the specific phy, it fails to find the bus_id.   Since we already know that 
the FEC
is working in 2.4 kernel runing the 8xx_io fec,  it must be something I have 
done
wrong with the fs_enet, 2 questions:

1) I understood that probably I didn't activate the bus, since I am porting 
it
from MPC885fads_setup.c, there is something I missed.  Currently I am using
montavista 4.0.1 which runing on kernel 2.6.10.; I noticed that the 
mdiobus_register
never get called.

2) what is the right way to do the mdiobus_register to register the phy bus?

TIA for your help.

A Jones

_________________________________________________________________
Laugh, share and connect with Windows Live Messenger 
http://clk.atdmt.com/MSN/go/msnnkwme0020000001msn/direct/01/?href=http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=hmtagline
