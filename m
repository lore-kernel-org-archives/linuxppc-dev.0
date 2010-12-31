Return-Path: <justinmattock@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E53561007F8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 11:09:41 +1100 (EST)
Received: by ywe10 with SMTP id 10so5116971ywe.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:09:38 -0800 (PST)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 2/5]drivers:staging:rtl8192e:ieee80211:rtl819x_HTProc.c Typo
	change singal to signal
Date: Thu, 30 Dec 2010 16:09:41 -0800
Message-Id: <1293754184-1928-2-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1293754184-1928-1-git-send-email-justinmattock@gmail.com>
References: <1293754184-1928-1-git-send-email-justinmattock@gmail.com>
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patches below fixes a typo "singal" to "signal". Please let me 
know if anything needs to be changed.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 .../staging/rtl8192e/ieee80211/rtl819x_HTProc.c    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/rtl8192e/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192e/ieee80211/rtl819x_HTProc.c
index b0c9c78..1be2b13 100644
--- a/drivers/staging/rtl8192e/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/ieee80211/rtl819x_HTProc.c
@@ -1007,7 +1007,7 @@ u8 HTFilterMCSRate( struct ieee80211_device* ieee, u8* pSupportMCS, u8* pOperate
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
 	// TODO: fill suggested rate adaptive rate index and give firmware info using Tx command packet
-	// we also shall suggested the first start rate set according to our singal strength
+	// we also shall suggested the first start rate set according to our signal strength
 	HT_PickMCSRate(ieee, pOperateMCS);
 
 	// For RTL819X, if pairwisekey = wep/tkip, we support only MCS0~7.
-- 
1.6.5.2.180.gc5b3e
