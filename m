Return-Path: <arend@broadcom.com>
Received: from mms1.broadcom.com (mms1.broadcom.com [216.31.210.17])
 by ozlabs.org (Postfix) with ESMTP id CD3922C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 17:33:26 +1000 (EST)
Message-ID: <524BCAC4.6060209@broadcom.com>
Date: Wed, 2 Oct 2013 09:27:00 +0200
From: "Arend van Spriel" <arend@broadcom.com>
MIME-Version: 1.0
To: "Joe Perches" <joe@perches.com>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net:drivers/net: Miscellaneous conversions
 to ETH_ALEN
References: <1380679480.2081.24.camel@joe-AO722>
In-Reply-To: <1380679480.2081.24.camel@joe-AO722>
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Cc: bridge@lists.linux-foundation.org, e1000-devel@lists.sourceforge.net,
 brcm80211-dev-list@broadcom.com, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 ath10k@lists.infradead.org, wil6210@qca.qualcomm.com,
 netfilter-devel <netfilter-devel@vger.kernel.org>, b43-dev@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/02/2013 04:04 AM, Joe Perches wrote:
> Convert the memset/memcpy uses of 6 to ETH_ALEN
> where appropriate.
>
> Also convert some struct definitions and u8 array
> declarations of [6] to ETH_ALEN.
>
For brcmsmac

Acked-by: Arend van Spriel <arend@broadcom.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>   drivers/net/wireless/brcm80211/brcmsmac/main.c     |  6 +-
