Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 7C0EADDFD7
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 00:14:13 +1000 (EST)
Date: Tue, 13 May 2008 18:14:12 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 0/6 v2] mpc83xx_wdt rework, support for mpc8610
Message-ID: <20080513141411.GA8981@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Thanks for the review, here is the new version.

Changes since v1:

- Scott Wood asked for mpc83xx_wdt on multiplatform kernels. Done via
  OF platform driver;
- Kumar Gala asked for mpc83xx_wdt -> mpc8xxx_wdt rename. Done in two
  steps;
- Segher Boessenkool noticed a negligence in the wdt device tree node.
  Fixed by removing mpc83xx_wdt compatible entry.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
