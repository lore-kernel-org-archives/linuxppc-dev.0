Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8FAC43218
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:43:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8865C208C2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8865C208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rsZZ4BPSzDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 23:43:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.133; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rrZr2yRqzDqbm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 22:58:44 +1000 (AEST)
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M7JvQ-1hPrWb2KvE-007on1; Sat, 27 Apr 2019 14:52:45 +0200
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/41] drivers: tty: serial: uartlite: remove unnecessary
 braces
Date: Sat, 27 Apr 2019 14:51:55 +0200
Message-Id: <1556369542-13247-15-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HNae7PjeMCnI/fvVc5Vcn1UOQeHvus2cVjs+T9ya7m11++AcCzd
 Uql6NzhkB+oflvXltCOBqXEgUK5TSZ1hR8ffTPAYNbY/DvgKZZPbUn10MDN7ED70JOmLeJq
 1lKUaLw3MrCqMLhiaWDxWKIAGg5En0Qog7emS9vPAAPWKLAw46CPLHZiyXdcej2Fh8Ze+9P
 mQVxOOn3Z+MSiWhjBR3rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/1Bsp3RvFpk=:jEj2BqutuAqHJLpEcMJKl5
 43Q2gnfjfbXOYmKCvLXPZKIAXZZUtWM/ggQ/3V+ep1h9oxBepGO53svk7tOAtUB4HTmGzETQU
 BGcf4lOQL1R9PGcjPpuqxVGycS5/yepMiBlhJpiTTiFO4zppn7B6xW6+OXEmjX8/L6TxPogIP
 BGJRlkMCpNregft1PTPoLHMfRbmypIa+63eD22zrsvKASyIVsVaH2GktV03lJL6vPnPPSTQLO
 D0YB4rKhf77wSPslUyp84LMYTD5hnHm8sZLao4A06bOZWEUA4GLTeQQ5EUSdLkxzpd7WGzOfy
 7kZt/p8jlh2F/bif4hzi0Y0icauYf2+lwB5PbWu5oMQahZ/y3ep1ee/xgYdsC3jTbPGhuWr4U
 m61U9b6CLrD0kZOU8ieFiHafssuzPLIZF8vm+I3mbIsa+ehI8tQ9a6aMPAIotC4cR8FEDW2JH
 soCibNbvEUFap8qbwUm+phNyvpZxN+o1puG0y/i5cJ3tKYFV4QPNojjrqFGVqXiDm5lQf9Lz0
 Nj1rgT4uTPa+A0jT9E0nUwyIsVQU+6IX1CBYUqua98ILDnTTPKXiFhStaSkGA6sjjQMaQfcEa
 bVuhmwJHPaxWI6jjnErph3P+P5UCkX66WTwbL+aM2uDYN/HpQzuGEtZm9zoona9khLFxN15O3
 60KpT4CPxa2vmxhbeHlY6OS2QFQnxojtU2MlGQ3DFrlEDbDf6IwC9JYle13db9SOZd19bpXhz
 y2ZuL53D1KtAFijP5hFy43ADOwAhnRooD3GPjw==
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org,
 linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org,
 vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org,
 khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com,
 matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org,
 andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

checkpatch complains:

    WARNING: braces {} are not necessary for any arm of this statement
    #489: FILE: drivers/tty/serial/uartlite.c:489:
    +	if (oops_in_progress) {
    [...]
    +	} else
    [...]

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index c322ab6..4c28600 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -486,9 +486,9 @@ static void ulite_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
-	if (oops_in_progress) {
+	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
-	} else
+	else
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* save and disable interrupt */
-- 
1.9.1

