Return-Path: <jean-baptiste.maneyrol@teamlog.com>
Received: from me-ml2.teamlog.fr (smtp-grenoble1.teamlog.com [194.2.68.40])
	by ozlabs.org (Postfix) with ESMTP id 42653679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Aug 2006 22:08:25 +1000 (EST)
Received: from teamlog.com
	by grenoble.teamlog.com (x.x.x/x.x.x) with ESMTP        
	id k73BG2dI019529
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Aug 2006 13:16:05 +0200
Subject: IBM OCP GPIO driver for linux 2.6
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 03 Aug 2006 13:15:51 +0200
Message-Id: <1154603751.17247.10.camel@jb-portable>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone, I'm a newbie here!

I'm porting a custom PPC 405GP card based on a Walnut from Montavista
Linux 3.0 (kernel 2.4.18) to linux 2.6, and I was wondering if there is
a port of the IBM OCP GPIO driver (a char driver providing
device /dev/gpio, major 10 minor 185). The driver was written by Armin
Kuster, and it doesn't exist in the stock kernel 2.6.17.7.

Let me known if a port exists, or if there is a new way of accessing the
PPC 405GP GPIO under linux 2.6. Otherwise, I will port this driver using
the IBM IIC driver as an example (for the things about OCP). In this
case, do anybody know where I can have the last version of this driver
(I have v 1.7 (07/25/02)) ? 

Thanks for all!


Jean-Baptiste Maneyrol
Teamlog - France
