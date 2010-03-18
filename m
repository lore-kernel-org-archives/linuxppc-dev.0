Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] wireless: Use macros from wireless.h
Date: Wed, 17 Mar 2010 23:21:33 -0700
Message-Id: <cover.1268892663.git.joe@perches.com>
Cc: orinoco-users@lists.sourceforge.net, Zhu Yi <yi.zhu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Corey Thomas <coreythomas@charter.net>,
	David Gibson <hermes@gibson.dropbear.id.au>,
	netdev@vger.kernel.org, orinoco-devel@lists.sourceforge.net,
	linux-wireless@vger.kernel.org, cbe-oss-dev@ozlabs.org,
	Intel Linux Wireless <ilw@linux.intel.com>, linuxppc-dev@ozlabs.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Johannes Berg <johannes@sipsolutions.net>,
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

Move the STD_IW_HANDLER macro from orinoco to wireless.h
Use the wireless.h macros in various wireless files
Remove local #defines of IW_IOCTL

Joe Perches (7):
  wireless.h: Add STD_IW_HANDLER macro
  net/wireless/wext_core.c: Use IW_IOCTL_IDX macro
  net/wireless/wext-core.c: Use IW_EVENT_IDX macro
  drivers/net/wireless: Use STD_IW_HANDLER macro
  drivers/net: Remove local #define IW_IOCTL, use STD_IW_HANDLER
  orinoco/wext.c: Remove local #define STD_IW_HANDLER
  wireless.h: Use SIOCIWFIRST not SIOCSIWCOMMIT for range check

 drivers/net/ps3_gelic_wireless.c       |   35 ++++----
 drivers/net/wireless/ipw2x00/ipw2200.c |   83 ++++++++++----------
 drivers/net/wireless/orinoco/wext.c    |    2 -
 drivers/net/wireless/ray_cs.c          |   40 +++++-----
 drivers/net/wireless/wl3501_cs.c       |   52 ++++++------
 include/linux/wireless.h               |    4 +-
 net/wireless/wext-core.c               |  134 ++++++++++++++++----------------
 7 files changed, 174 insertions(+), 176 deletions(-)
