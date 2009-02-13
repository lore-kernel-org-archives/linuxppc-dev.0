Return-Path: <willy.jacobs@nl.thalesgroup.com>
Received: from spvl1106.nl.thalesgroup.com (spvl1106.nl.thalesgroup.com
	[212.178.200.70]) by ozlabs.org (Postfix) with ESMTP id 02962DDF7C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 22:04:21 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by spvl1106.nl.thalesgroup.com (Postfix) with ESMTP id C0231F78C4
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 11:35:18 +0100 (CET)
Received: from spvl1106.nl.thalesgroup.com ([127.0.0.1])
	by localhost (mailgate4.nl.thalesgroup.com [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id Ey8rOcGBIluE for <linuxppc-dev@ozlabs.org>;
	Fri, 13 Feb 2009 11:35:15 +0100 (CET)
Received: from mta1.nl.thales (mta1.nl.thales [193.67.31.130])
	by spvl1106.nl.thalesgroup.com (Postfix) with ESMTP id 3A192F78C0
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 11:35:15 +0100 (CET)
Received: from spvl1179.nl.thalesgroup.com (hglsmtp1 [10.160.62.100])
	by mta1.nl.thales (4.9.7.3) with ESMTP id Li894AAu
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 11:34:21 +0100 (MET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by spvl1179.nl.thalesgroup.com (Postfix) with ESMTP id EFE27E7928
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 11:34:20 +0100 (CET)
Received: from spvl1179.nl.thalesgroup.com ([127.0.0.1])
	by localhost (hglsmtp1.hengelo.nl.thales [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id KJZv2hNU6OxH for <linuxppc-dev@ozlabs.org>;
	Fri, 13 Feb 2009 11:34:17 +0100 (CET)
Received: from [144.18.5.94] (s203631.hengelo.nl.thales [144.18.5.94])
	by spvl1179.nl.thalesgroup.com (Postfix) with ESMTP id 1E1B8E7900
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 11:34:17 +0100 (CET)
Message-ID: <49954CA9.9040203@nl.thalesgroup.com>
Date: Fri, 13 Feb 2009 11:34:17 +0100
From: willy jacobs <willy.jacobs@nl.thalesgroup.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Gianfar ethernet MPC85xx driver not seen anymore when moving to 2.6.29
	kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When I moved (config file and device tree) from 2.6.28 (and earlier kernel releases) to 2.6.29-rc2 for some reason
the Gianfar driver is correctly compiled in, but not probed anymore during kernel booting.

I looked into the Changelogs, but did'nt see any change regarding this.

Do I need to change the device tree and/ir config file?
-- 
willy
Unclassified

------------------------------------------------------------------------------------------------------------
Disclaimer:

If you are not the intended recipient of this email, please notify the sender and delete it. 
Any unauthorized copying, disclosure or distribution of this email or its attachment(s) is forbidden. 
Thales Nederland BV will not accept liability for any damage caused by this email or its attachment(s). 
Thales Nederland BV is seated in Hengelo and is registered at the Chamber of Commerce under number 06061578.
------------------------------------------------------------------------------------------------------------
