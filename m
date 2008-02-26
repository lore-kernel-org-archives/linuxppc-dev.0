Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18371.57542.77446.443231@cargo.ozlabs.ibm.com>
Date: Tue, 26 Feb 2008 20:49:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [patch 0/6] pasemi_mac updates for 2.6.26
In-Reply-To: <20080221025753.903665000@lixom.net>
References: <20080221025753.903665000@lixom.net>
Cc: netdev@vger.kernel.org, pasemi-linux@ozlabs.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Here's a set of updates for pasemi_mac for 2.6.26. Some of them touch
> the dma_lib in the platform code as well, but it's easier if it's all
> merged through netdev to avoid dependencies.
> 
> Major highlights are jumbo frame support and ethtool basics, the rest
> is mostly minor plumbing around it.

What route do you think these should take upstream?  I'm happy to take
them if Jeff is OK with that.

Paul.
