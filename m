Date: Tue, 23 May 2000 19:48:29 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Sergio Brandano <sb@dcs.qmw.ac.uk>
cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
        stephan@jvc.nl
Subject: Debian pmud package available 
In-Reply-To: <200005221545.QAA23486@copper.dcs.qmw.ac.uk>
Message-ID: <Pine.LNX.4.10.10005231934210.4083-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 May 2000, Sergio Brandano wrote:

> >Speaking of which: can someone point me to the URL for the 0.6 pmud
> >source? If no one else is interested, I'd package it for Debian.
>
>  Just visit my page:
>  http://www.dcs.qmw.ac.uk/~sb/PowerBook.html
>
>  Look under the "Power Management" section. You will find the
>  intructions for a Debian installation and relative init file (written
>  by me). Please contact Stephan Leemburg (stephan@jvc.nl) for it all.

OK, the Debian package plus diff/changes/dsc stuff is up for testing on
ftp.biophys.uni-duesseldorf.de:/pub/linux/powerpc - it's not a final
version yet, I need to figure out how to have the Debian postinst
automatically create the /etc/rc*.d symlinks. If someone wants to play
with it, go ahead.

With 2.2.15pre9 kernel headers, I had to use the following patch to make
pmud-0.6 compile on LinuxPPC:

--- pmud-0.6/pmu.h.org	Mon May 22 18:26:31 2000
+++ pmud-0.6/pmu.h	Mon May 22 18:27:08 2000
@@ -19,8 +19,3 @@

 #define PMU_SMART_BATT		0x6f	/* report smart battery state */
 #define PMU_GET_VERSION		0xea	/* get pmu firmware version # */
-
-/* Kind of PMU (model) */
-enum {
-	PMU_KEYLARGO_BASED=3,	/* iBook */
-};

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
