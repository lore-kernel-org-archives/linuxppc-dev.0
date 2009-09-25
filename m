Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CA356B7043
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 20:09:00 +1000 (EST)
Message-ID: <4ABC94ED.6070508@grandegger.com>
Date: Fri, 25 Sep 2009 12:01:17 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] i2c-mpc: Do not generate STOP after read.
References: <1253620242-18461-1-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1253620242-18461-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Esben Haabendal <eha@doredevelopment.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> The driver always ends a read with a STOP condition which
> breaks subsequent I2C reads/writes in the same transaction as
> these expect to do a repeated START(ReSTART).
> 
> This will also help I2C multimaster as the bus will not be released
> after the first read, but when the whole transaction ends.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Tested-by: Wolfgang Grandegger <wg@grandegger.com>

on a MPC8548 board with an up-to-date kernel. I did not realize any
problems.

Wolfgang.
