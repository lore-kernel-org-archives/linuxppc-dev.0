Message-Id: <v03130303b3fdfbeb11d0@[192.168.1.1]>
In-Reply-To: <37D838A4.B65C5AA3@wanadoo.fr>
References: <37D74322.B787B9FE@loomer.com> <19990909092545.C4200@io.nu>
 <37D7C974.77E93281@loomer.com> <37D820B5.F84B223D@wanadoo.fr>
 <19990909163058.A22217@io.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 9 Sep 1999 19:07:08 -0500
To: Martin Costabel <costabel@wanadoo.fr>, Shaw Terwilliger <sterwill@io.nu>
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: Paul's devel branch on Lombard?
Cc: Hugh Caley <hcaley@loomer.com>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:

>2.3.17 is now running, although I had to recompile it once; make
>oldconfig had eaten my CONFIG_ADBMOUSE. Someone is playing games with
>the config options. In make menuconfig, the "APPLE DESKTOP MOUSE" is
>marked as "NEW". Mine doesn't look very new anymore :-)

It probably changed to CONFIG_ADB_MOUSE.  This may be a side-effect of the
ADB merger between Linux/m68k and LinuxPPC.

Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
