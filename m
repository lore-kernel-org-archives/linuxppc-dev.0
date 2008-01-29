Return-Path: <ssh@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id 2B0F5DE008
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 04:08:45 +1100 (EST)
Received: from bryce.americas.sgi.com (bryce.americas.sgi.com [137.38.224.20])
	by relay1.corp.sgi.com (Postfix) with ESMTP id A52A08F8087
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 09:08:43 -0800 (PST)
Received: from [137.38.88.32] (lnx-ssh.americas.sgi.com [137.38.88.32])
	by bryce.americas.sgi.com (Postfix) with ESMTP id 5856370008E3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 11:08:43 -0600 (CST)
Message-ID: <479F5D9B.8040403@sgi.com>
Date: Tue, 29 Jan 2008 11:08:43 -0600
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Configuring Freecale ucc_geth without a PHY
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I have a custom board with an MPC8358 (our board is based
off of the MPC8360E-MDS development board) that has its eth's
directly connected (GMII) to a Broadcom network switch
part on the same board, with no PHYs between them.
We've have been using a 2.6.16.18 kernel (from TimeSys) up
until now, and I hacked in some crude support for no-phy
configs forced to 100Mbit and 1Gbit speeds.   Now I'm
moving to 2.6.22 (with 8360 the patches from bitshrine.org),
and I'm trying to understand how I should do this with
device trees, the new PHY infrastructure, etc.   Has anyone
else needed this support?   Does anyone have any suggestions
as to how to tackle it?

Thanks,
Steve

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.                          
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
