Return-Path: <KHUISMAN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	by ozlabs.org (Postfix) with ESMTP id B2B07DDF94
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 08:01:59 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com
	[47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	n48LaQd00225
	for <linuxppc-dev@ozlabs.org>; Fri, 8 May 2009 21:36:26 GMT
Message-ID: <4A04A5D7.10106@nortel.com>
Date: Fri, 08 May 2009 17:36:23 -0400
From: "Ken Huisman" <khuisman@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: question about fs_enet driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is there a way to configure the fs_enet driver to use rmii mode for one 
of the ethernet devices in
my device tree?  I know other drivers support a keyword in the device 
tree (such as phy-connection-type = "rmii")
but the following line of code in fs_enet-main.c (fs_init_phy()) 
suggests to me that mii mode is hard-coded for this driver:

        phydev = phy_connect(dev, fep->fpi->bus_id, &fs_adjust_link, 0,
                PHY_INTERFACE_MODE_MII);

am I correct in my understanding, or is this set up a different way for 
the fs_enet driver?

thanks

Ken
