Return-Path: <johannes@sipsolutions.net>
Subject: Re: [PATCH v2 0/7] wireless: Use macros from wireless.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Joe Perches <joe@perches.com>
In-Reply-To: <cover.1268892663.git.joe@perches.com>
References: <cover.1268892663.git.joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Mar 2010 09:21:53 -0700
Message-ID: <1268929313.4005.9.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Cc: orinoco-users@lists.sourceforge.net, Zhu Yi <yi.zhu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Corey Thomas <coreythomas@charter.net>,
	David Gibson <hermes@gibson.dropbear.id.au>,
	netdev@vger.kernel.org, orinoco-devel@lists.sourceforge.net,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Intel Linux Wireless <ilw@linux.intel.com>, linuxppc-dev@ozlabs.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, cbe-oss-dev@ozlabs.org,
	Richard Kennedy <richard@rsk.demon.co.uk>,
	"David S. Miller" <davem@davemloft.net>, Pavel Roskin <proski@gnu.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-03-17 at 23:21 -0700, Joe Perches wrote:
> Move the STD_IW_HANDLER macro from orinoco to wireless.h
> Use the wireless.h macros in various wireless files
> Remove local #defines of IW_IOCTL

I really don't want to debug any breakage here, but otherwise I don't
care and this is fine with me.

johannes
