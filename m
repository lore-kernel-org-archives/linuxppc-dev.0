Return-Path: <spitzauer_77@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C9023DDFBE
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 00:23:00 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 03 May 2007 16:22:59 +0200
From: spitzauer_77@gmx.de
Message-ID: <20070503142259.222640@gmx.net>
MIME-Version: 1.0
Subject: Writing an AC97 device driver for MPC52xx
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

i try to write device driver for an AC97 external codec on MPC5200 controller. The PSC1 and 2 on MPC5200 can be configured as AC97.

I'm a little bit new in this topic of writing linux drivers and read a lot in the internet about this. (e.g. http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x1052.htm )

But i have some questions:

- Is there a simple driver maybe on other platforms available, which have the same problem solved?? Most of the sound drivers are coupled with pci.

- I only have to write the pure hardware (PSC) stuff, or?? I'm little confused on how i should handle this with AC97 (ac97_codec.c) and ALSA.

- Is this for my driver the correct layer:
  User App -> ALSA -> AC97 -> "My driver" -> Hardware MPC52xx


I'm glad for any hint!

Spitzauer
-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
