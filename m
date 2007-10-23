Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D9D77DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 09:51:56 +1000 (EST)
Date: Tue, 23 Oct 2007 18:59:05 -0500
From: Olof Johansson <olof@lixom.net>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 01/11] [POWERPC] Add 'machine: ...' line to common
	show_cpuinfo()
Message-ID: <20071023235905.GA10821@lixom.net>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231309.29359.20887.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023231309.29359.20887.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24, 2007 at 01:13:09AM +0200, Marian Balakowicz wrote:
> Print out '/model' property as a machine name in generic
> show_cpuinfo() routine.

Excellent! I was thinking about adding this just the other day since I
couldn't tell which kind of board I was on.

> Signed-off-by: Marian Balakowicz <m8@semihalf.com>

Acked-by: Olof Johansson <olof@lixom.net>
