Return-Path: <olof@lixom.net>
Message-Id: <20080221025753.903665000@lixom.net>
Date: Wed, 20 Feb 2008 20:57:53 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [patch 0/6] pasemi_mac updates for 2.6.26
Cc: netdev@vger.kernel.org, pasemi-linux@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a set of updates for pasemi_mac for 2.6.26. Some of them touch
the dma_lib in the platform code as well, but it's easier if it's all
merged through netdev to avoid dependencies.

Major highlights are jumbo frame support and ethtool basics, the rest
is mostly minor plumbing around it.

-- 
