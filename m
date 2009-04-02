Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 796D0DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 23:40:24 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Harry Ciao <qingtao.cao@windriver.com>
Subject: Re: [v0 PATCH 2/5] EDAC: Add CPC925 driver source file
Date: Thu, 2 Apr 2009 14:40:16 +0200
References: <1238652440-9224-1-git-send-email-qingtao.cao@windriver.com>
	<1238652440-9224-2-git-send-email-qingtao.cao@windriver.com>
	<1238652440-9224-3-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1238652440-9224-3-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200904021440.17366.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, norsk5@yahoo.com, linux-kernel@vger.kernel.org,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 02 April 2009, Harry Ciao wrote:
> Introduce IBM CPC925 EDAC driver source file, which makes use of error
> detections on the IBM CPC925 Bridge and Memory Controller.
> 
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>

On a very brief review, the driver looks good to me, but please
post the full series to the linuxppc-dev@ozlabs.org mailing list
as well, because that is likely to have more people that will
comment on it.

The first three patches of your series should be merged into
a single one, because none of them has any signficance by itself.
You may also consider moving the contents of the header file
into the main driver, because it does not actually act as an
interface.

	Arnd <><
