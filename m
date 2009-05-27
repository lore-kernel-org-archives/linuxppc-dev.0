Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C099DDDFED
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 13:48:19 +1000 (EST)
Date: Tue, 26 May 2009 20:48:15 -0700 (PDT)
Message-Id: <20090526.204815.185454308.davem@davemloft.net>
To: Xiaotian.Feng@windriver.com
Subject: Re: [PATCH net] gianfar: fix babbling rx error event bug
From: David Miller <davem@davemloft.net>
In-Reply-To: <1243389156-1668-1-git-send-email-Xiaotian.Feng@windriver.com>
References: <1243389156-1668-1-git-send-email-Xiaotian.Feng@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Xiaotian Feng <Xiaotian.Feng@windriver.com>
Date: Wed, 27 May 2009 09:52:36 +0800

> Gianfar interrupt handler uses IEVENT_ERR_MASK to check and handle errors.
> Babbling RX error (IEVENT_BABR) should be included in IEVENT_ERROR_MASK.
> Otherwise if BABR is raised, it never gets handled nor cleared, and an
> interrupt storm results. This has been observed to happen on sending a
> burst of ethernet frames to a gianfar based board.
> 
> Signed-off-by: Xiaotian Feng <xiaotian.feng@windriver.com>

Patch applied, thanks.
