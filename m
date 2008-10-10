Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 15591DE57B
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 01:03:47 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH v7] PPC440EPx gpio driver
Date: Fri, 10 Oct 2008 16:02:32 +0200
References: <48EF5DDB.7060302@harris.com>
In-Reply-To: <48EF5DDB.7060302@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810101602.33052.sr@denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 October 2008, Steven A. Falco wrote:
> This patch adds support for the GPIO functions of PPC40x and PPC44x
> SOCs.

Looks good. But you should change the subject line now. Its not only a 
PPC440EPx gpio driver but ppc4xx. Also please add "powerpc/4xx: " to the 
beginning of the subject line. And you should always send 4xx related patches 
to the subsystem maintainer too (CC), in this case Josh Boyer.

> Signed-off-by: Steve Falco <sfalco at harris.com>

You can add my:

Acked-by: Stefan Roese <sr@denx.de>

in the next patch revision. :)

Best regards,
Stefan
