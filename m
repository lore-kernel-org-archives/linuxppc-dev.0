Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5D5A1DDF1F
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 02:45:28 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] tuning options for PPC64
Date: Sat, 26 Jul 2008 18:33:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807261833.55994.marvin24@gmx.de>
Cc: olof@lixom.net, miltonm@bga.com, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this is my second attempt to introduce some tuning options for PPC64. These 
patches are much less invasive as the previous patchset. 

Because the power cpus seem to have various features I don't know/understand I 
didn't touch any feature flags/config options this time, but focused only on 
the compiler flags.

Nevertheless feature flags and cleanups can be added later based on the cpu 
selection as Milton suggested. I will try this if these patches receive 
a "GO!".

Also, as Arndt suggested, I used separate mcpu and mtune options but didn't 
force the user to use it.

As always, comments are welcome.

Greetings

Marvin
