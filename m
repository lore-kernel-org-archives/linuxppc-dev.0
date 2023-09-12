Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8AFEE3F00
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Sep 2023 18:16:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlWwz29S8z3d80
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:16:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=212.18.0.9; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlWwN5S9tz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2023 04:15:30 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4RlWwC135qz1r1s2;
	Tue, 12 Sep 2023 20:15:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4RlWwB50vFz1qqlS;
	Tue, 12 Sep 2023 20:15:22 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id arhQ5hNygLDL; Tue, 12 Sep 2023 20:15:21 +0200 (CEST)
X-Auth-Info: LN9l6lzYo3wMMEsRLdqLpHZLr7RgI7m9M4Jqn66rlBUyfCIb+Ct3msFl3Xeza20M
Received: from igel.home (aftr-62-216-205-103.dynamic.mnet-online.de [62.216.205.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 12 Sep 2023 20:15:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 78B1B2C128C; Tue, 12 Sep 2023 20:15:21 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
In-Reply-To: <87bkeotin8.fsf@igel.home> (Andreas Schwab's message of "Wed, 30
	Aug 2023 21:49:47 +0200")
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
	<20230819004356.1454718-2-Liam.Howlett@oracle.com>
	<87bkeotin8.fsf@igel.home>
X-Yow: Hey!!  Let's watch the' ELEVATOR go UP and DOWN at th' HILTON HOTEL!!
Date: Tue, 12 Sep 2023 20:15:21 +0200
Message-ID: <87edj3b6me.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, maple-tree@lists.infradead.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Any news?  This is still broken.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
