Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 12:45:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 4/5] of: define CONFIG_OF globally so architectures can
	select it
Message-Id: <20100629124551.06fe1015.sfr@canb.auug.org.au>
In-Reply-To: <20100629123843.5f94d477.sfr@canb.auug.org.au>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
	<20100629123843.5f94d477.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
	David Miller <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/of/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 7cecc8f..1678dbc 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -1,3 +1,6 @@
+config OF
+	bool
+
 config OF_FLATTREE
 	bool
 	depends on OF
-- 
1.7.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
