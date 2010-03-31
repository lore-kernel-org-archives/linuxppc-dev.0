Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4BB38C83.9090808@am.sony.com>
Date: Wed, 31 Mar 2010 10:55:15 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 5/7] drivers/net: Remove local #define IW_IOCTL, use
	STD_IW_HANDLER
References: <cover.1268892663.git.joe@perches.com>
	<696c60e097ff35aeb2d746d1a0edf167514f2b61.1268892664.git.joe@perches.com>
In-Reply-To: <696c60e097ff35aeb2d746d1a0edf167514f2b61.1268892664.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Zhu Yi <yi.zhu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Intel Linux Wireless <ilw@linux.intel.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Kennedy <richard@rsk.demon.co.uk>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 03/17/2010 11:21 PM, Joe Perches wrote:
> Use #define STD_IW_HANDLER from wireless.h instead
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ps3_gelic_wireless.c       |   35 +++++++-------
>  drivers/net/wireless/ipw2x00/ipw2200.c |   83 ++++++++++++++++----------------
>  2 files changed, 58 insertions(+), 60 deletions(-)

Sorry for the delay.  This looks fine for the PS3.

Acked-by: Geoff Levand <geoff@infradead.org>
