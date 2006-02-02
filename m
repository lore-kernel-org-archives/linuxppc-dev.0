Return-Path: <pochini@shiny.it>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by ozlabs.org (Postfix) with ESMTP id 15D1E68A3A
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 03:00:39 +1100 (EST)
Received: from agnus (agnus.shiny.it [194.20.232.6])
	by denise.shiny.it (8.11.7/8.11.6) with ESMTP id k12FjrG14867
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Feb 2006 16:45:53 +0100
Message-ID: <XFMail.20060202164555.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Date: Thu, 02 Feb 2006 16:45:55 +0100 (CET)
Sender: pochini@agnus.shiny.it
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@ozlabs.org
Subject: Is /sys/.../power/state supported ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


echo 3 > /sys/pci.../power/state  does nothing on my machine.
I have a PMac dual-G4 MDD, linux 2.6.14 and of course
CONFIG_PM and debug are enabled. It writes nothing in the
logs and the value it reads from any device/power/state is
always 0, no matter what I wrote into it. I wonder if it is
supposed to work, or if it not supported yet... or maybe if
I'm missing something.


--
Giuliano.
