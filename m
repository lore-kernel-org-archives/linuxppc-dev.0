Return-Path: <davem@davemloft.net>
Date: Thu, 17 Nov 2011 17:05:26 -0500 (EST)
Message-Id: <20111117.170526.1920810007806589605.davem@davemloft.net>
To: wg@grandegger.com
Subject: Re: [PATCH net-next] ibm/emac: fix improper cleanup when device is
 removed to allow re-bind
From: David Miller <davem@davemloft.net>
In-Reply-To: <4EC506E4.5060806@grandegger.com>
References: <4EC506E4.5060806@grandegger.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: Netdev@vger.kernel.org, Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@grandegger.com>
Date: Thu, 17 Nov 2011 14:06:44 +0100

> The re-binding (unbind..bind) of an EMAC device fails because the
> static variable "busy_phy_map" is not updated when the device is
> removed.
> 
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>

Applied, thanks.
