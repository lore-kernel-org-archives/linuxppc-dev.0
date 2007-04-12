Return-Path: <dave.jiang@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 443B2DDF7E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 05:54:40 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so554075pyb
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 12:54:38 -0700 (PDT)
Message-ID: <8746466a0704121254h205a8247u39587560991f07a4@mail.gmail.com>
Date: Thu, 12 Apr 2007 12:54:38 -0700
From: Dave <dave.jiang@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: booke_wdt being a kernel module
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does it make sense for the booke_wdt driver to be a kernel module?
Since the watchdog cannot be stopped, unloading the module after the
watchdog has started basically garantees a reboot.... Should
CONFIG_BOOKE_WDT be changed to a bool from tristate?
-- 
-= Dave =-
