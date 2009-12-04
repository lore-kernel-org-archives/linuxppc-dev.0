Return-Path: <pengxihan@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id 69C42B7BDE
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 13:47:17 +1100 (EST)
Received: by pwi5 with SMTP id 5so959998pwi.9
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Dec 2009 18:47:16 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 4 Dec 2009 10:47:16 +0800
Message-ID: <389deec70912031847x4ab3e74u8c13083275c83d21@mail.gmail.com>
Subject: 'High Resolution Timer Support' enabled cause CPU usage increase!
From: hank peng <pengxihan@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,All:
CPU is MPC8548, kernel version is 2.6.31.6. When I enabled this
option, my application's CPU usage increased, then I disabled this
option, CPU usage dropped to normal level.
I also tested on 2.6.30, the result is same.

-- 
The simplest is not all best but the best is surely the simplest!
