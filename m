Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 71B6EB7BEE
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 12:39:47 +1100 (EST)
Date: Mon, 15 Feb 2010 17:33:33 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] hwmon: (ams) Fix device removal sequence
In-Reply-To: <20100131150323.06e0c876@hyperion.delvare>
Message-ID: <alpine.DEB.2.01.1002151716240.28195@bogon.housecafe.de>
References: <20100131150323.06e0c876@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Stelian Pop <stelian@popies.net>,
	Michael Hanselmann <linux-kernel@hansmi.ch>,
	LM Sensors <lm-sensors@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

I cannot find those two patches from Jean [0] in your tree, I take it 
they'll be included and pushed to Linus in 2.6.34 then?

(Although I had hoped to see them in 2.6.33, I'm "testing"[1] them since 
 -rc2 on my PowerBook)

Thanks,
Christian.

[0] http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-February/079958.html
    http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-February/079959.html
[1] http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg40983.html

-- 
BOFH excuse #342:

HTTPD Error 4004 : very old Intel cpu - insufficient processing power
