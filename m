Return-Path: <n_tbinh@yahoo.com>
Received: from web30710.mail.mud.yahoo.com (web30710.mail.mud.yahoo.com
	[68.142.200.143]) by ozlabs.org (Postfix) with SMTP id 12ADF68744
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 19:26:38 +1100 (EST)
Message-ID: <20051117081956.4614.qmail@web30710.mail.mud.yahoo.com>
Date: Thu, 17 Nov 2005 08:19:56 +0000 (GMT)
From: Nguyen Thanh Binh <n_tbinh@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Booting hangs after "Calibrating delay loop..."
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

When booting Monta Vista Linux on Memec board
(Virtex-4 FX12 LC), it hung after printing the
following message:

    "Calibrating delay loop..."

By looking at the source code, I found that in the
init/main.c the problem came from the
calibrate_delay()
function: jiffies was not incremented (jiffies was
always equal to 0).

Have anyone get the similar problem or any experience
to fix it?

Thank you.

Binh Nguyen

Nguy&#7877;n Thanh Bình


		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
