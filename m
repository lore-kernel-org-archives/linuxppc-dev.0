Return-Path: <groeck@redback.com>
Received: from imr3.ericy.com (imr3.ericy.com [198.24.6.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7E291007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 15:42:03 +1000 (EST)
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: "James E.J. Bottomley" <James.Bottomley@suse.de>,
	Richard Purdie <rpurdie@rpsys.net>, Greg Kroah-Hartman <gregkh@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/6] Remove owner field from sysfs struct attribute
Date: Wed, 28 Jul 2010 22:09:26 -0700
Message-ID: <1280380166-29196-7-git-send-email-guenter.roeck@ericsson.com>
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
 include/linux/sysfs.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index f2694eb..880fa1a 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -22,14 +22,8 @@ struct kobject;
 struct module;
 enum kobj_ns_type;
 
-/* FIXME
- * The *owner field is no longer used.
- * x86 tree has been cleaned up. The owner
- * attribute is still left for other arches.
- */
 struct attribute {
 	const char		*name;
-	struct module		*owner;
 	mode_t			mode;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lock_class_key	*key;
-- 
1.7.0.87.g0901d
