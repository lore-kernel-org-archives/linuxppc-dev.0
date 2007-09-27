Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 0F74BDDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 21:46:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] ibmebus: Remove bus match/probe/remove functions
Date: Thu, 27 Sep 2007 13:30:29 +0200
References: <200709261143.24735.fenkes@de.ibm.com>
	<200709261144.57606.fenkes@de.ibm.com>
In-Reply-To: <200709261144.57606.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709271330.30474.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 September 2007, Joachim Fenkes wrote:
> Remove old code that will be replaced by rewritten and shorter functions in
> the next patch. Keep struct ibmebus_dev and struct ibmebus_driver for now,
> but replace ibmebus_{,un}register_driver() by dummy functions. This way, the
> kernel will still compile and run during the transition and git bisect will
> be happy.
> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
