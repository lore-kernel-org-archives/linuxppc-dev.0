Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A16C43218
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:09:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F443208C2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F443208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rrqZ0wtPzDqR7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 23:09:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.130; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rrSg3JFmzDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 22:53:15 +1000 (AEST)
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M26iv-1hMqrC03Wz-002bb0; Sat, 27 Apr 2019 14:52:43 +0200
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/41] drivers: tty: serial: sb1250-duart: fix formatting error
Date: Sat, 27 Apr 2019 14:51:52 +0200
Message-Id: <1556369542-13247-12-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:+TzVLpdAa88s4dLeOAxWyCsRhuc7KaUZKNLF0uRArPgYGfXSgiH
 Cc2vSSp3JHtH5Dh6TLARezDiIKDVv/NGSmiD/ku3dsWnfWOrtj1Cfj89ntRTXnSvx6PBKgU
 dt1TF7JLIo4mMJjyQ165GdSVmp05k1wOQx9x8rk+vVa9HNdzhgzqFQ2ZALqM5/sIDIRqkKv
 zpE63Uj8QixDSf+H4FfiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7g9mhemK6rI=:1LPea258+vT4cAu97il+UN
 TYKyF9QgPM9xIe6eeQ+jqNe+ggTMLP2Rvkb4j9U9H13Sg9CbVn9iCrF0YTfPvJy7st+0uGM2f
 /PnRFLO51z8114t2VgJaesPsgRavI/NG+JNJ7cfluxQbMaKGaxT6e/dwtJS7cjr1YYOomqA9G
 muP/UMza5Daoz+E60ichje3jvTqidA4lMSrQ9I6Hysh36D1wrMiCAB8NPPvc4nrvaddLXw6wB
 HgP1Z28SnAs7F4M7EpvU2+lQ0OTn37drJgeY/1adD+7p8We3CNEdSVlX/aiCHuYBdhtA0tQwk
 twP7c4eBkXAVXYagsNKW0MBlXlR0YW7fkDWkpusCcqgmZEquGN++8kKA5YtYIXEcg1RQIv5ze
 3sYNpA8wkk3GGqvshvtdRF4i/V07DDAKHjaZS4rViY5umoot7vu2gWZ7lETfiboO5z0AnKiNW
 ArDLwY9233EwB1kTHm54Jg7uCj6lRpmvrGsTo5d38MvHFBdNvTBRnyt2zIMulQmJtFb8kkKio
 L5hyUjTr2yPVMh8mBfg+gFuzlyXZDST0R3Rsxc16FX1n2PRzy15BgDF5VnY6vbekE+syIAUnQ
 CpezAGe8b0r4rC4XtzPF0T9lR/Pa1UWdKJH90iIIxuaLrBDvbaT57qKKbgRo+xkQtguPp6B41
 KnkPQ1UxL/FbNXzdFiuI/RSGrM7xIsl18lv3lduPbUzSCDcj7qPBT1cj99Wx+ndaKrPl0OaXi
 dDx2xwj2GagsyKcjT96JpuA4aPHWH0zLebvvLA==
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

    ERROR: space required before the open parenthesis '('
    #659: FILE: drivers/tty/serial/sb1250-duart.c:659:
    +	if(refcount_dec_and_test(&duart->map_guard))

Just add this missing space to make checkpatch happy.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index ec74f09..0023ed0 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -656,7 +656,7 @@ static void sbd_release_port(struct uart_port *uport)
 	iounmap(uport->membase);
 	uport->membase = NULL;
 
-	if(refcount_dec_and_test(&duart->map_guard))
+	if (refcount_dec_and_test(&duart->map_guard))
 		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
 	release_mem_region(uport->mapbase, uport->mapsize);
 }
-- 
1.9.1

