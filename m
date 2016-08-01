Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3BCs0Zc7zDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 06:44:55 +1000 (AEST)
Date: Mon, 01 Aug 2016 13:44:53 -0700 (PDT)
Message-Id: <20160801.134453.885913890617619367.davem@davemloft.net>
To: xypron.glpk@gmx.de
Cc: qiang.zhao@nxp.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] wan/fsl_ucc_hdlc: avoid possible NULL pointer
 dereference
From: David Miller <davem@davemloft.net>
In-Reply-To: <1469963663-3005-1-git-send-email-xypron.glpk@gmx.de>
References: <1469963663-3005-1-git-send-email-xypron.glpk@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Sun, 31 Jul 2016 13:14:23 +0200

> All assignments to components of priv should only
> occur after the check if prif is NULL.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied.
