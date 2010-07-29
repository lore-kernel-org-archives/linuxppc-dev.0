Return-Path: <groeck@redback.com>
Received: from imr3.ericy.com (imr3.ericy.com [198.24.6.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D2701007D2
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 15:42:08 +1000 (EST)
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: "James E.J. Bottomley" <James.Bottomley@suse.de>,
	Richard Purdie <rpurdie@rpsys.net>, Greg Kroah-Hartman <gregkh@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/6] scsi: Remove owner field from attribute initialization in
	ARCMSR driver
Date: Wed, 28 Jul 2010 22:09:22 -0700
Message-ID: <1280380166-29196-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
References: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Guenter Roeck <guenter.roeck@ericsson.com>,
	Nick Cheng <nick.cheng@areca.com.tw>,
	Linus Walleij <linus.walleij@stericsson.com>,
	James Smart <james.smart@emulex.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	Dmitry Torokhov <dtor@mail.ru>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
	Tejun Heo <tj@kernel.org>, Alex Iannicelli <alex.iannicelli@emulex.com>,
	Jani Nikula <ext-jani.1.nikula@nokia.com>,
	Jean Delvare <khali@linux-fr.org>,
	Benjamin Thery <benjamin.thery@bull.net>,
	linux-scsi@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/scsi/arcmsr/arcmsr_attr.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
index 07fdfe5..a4e04c5 100644
--- a/drivers/scsi/arcmsr/arcmsr_attr.c
+++ b/drivers/scsi/arcmsr/arcmsr_attr.c
@@ -192,7 +192,6 @@ static struct bin_attribute arcmsr_sysfs_message_read_attr = {
 	.attr = {
 		.name = "mu_read",
 		.mode = S_IRUSR ,
-		.owner = THIS_MODULE,
 	},
 	.size = 1032,
 	.read = arcmsr_sysfs_iop_message_read,
@@ -202,7 +201,6 @@ static struct bin_attribute arcmsr_sysfs_message_write_attr = {
 	.attr = {
 		.name = "mu_write",
 		.mode = S_IWUSR,
-		.owner = THIS_MODULE,
 	},
 	.size = 1032,
 	.write = arcmsr_sysfs_iop_message_write,
@@ -212,7 +210,6 @@ static struct bin_attribute arcmsr_sysfs_message_clear_attr = {
 	.attr = {
 		.name = "mu_clear",
 		.mode = S_IWUSR,
-		.owner = THIS_MODULE,
 	},
 	.size = 1,
 	.write = arcmsr_sysfs_iop_message_clear,
-- 
1.7.0.87.g0901d
