Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id 9F314DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 20:03:00 +1100 (EST)
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id lAS8qrfj002774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 17:52:54 +0900 (JST)
Date: Wed, 28 Nov 2007 17:52:38 +0900 (JST)
Message-Id: <20071128.175238.-1300543742.kouish@swc.toshiba.co.jp>
To: gorcunov@gmail.com
Subject: Re: [PATCH] PPC: CELLEB - fix potential NULL pointer dereference
In-Reply-To: <aa79d98a0711252346m583b652bocf72e11077da352e@mail.gmail.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch adds checking for NULL value returned to prevent possible
> NULL pointer dereference.
> Also two unneeded 'return' are removed.
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>

Thanks, I tested your patch and it works.

My original code supposes that the device-tree is provided correctly,
so I omited such checks. (Sorry, it should have been commented.)

Should we check more strictly like your patch?

Best regards,
Kou Ishizaki
