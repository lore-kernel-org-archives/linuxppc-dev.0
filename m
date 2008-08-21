Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: New Patchwork beta
Date: Thu, 21 Aug 2008 18:22:26 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808211822.27786.jk@ozlabs.org>
Cc: linux-mtd@lists.infradead.org, bazaar-ng@lists.canonical.com,
	cbe-oss-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I've just put up a new beta of patchwork:

  http://patchwork2.ozlabs.org/

I intend to replace the existing patchwork with the new code, but would 
like to get it tested first. There aren't many patches in the system at 
the moment, but it'll receive patches from the relevant lists. I'll 
also import a set of existing mails tomorrow, to give some sample data 
to test with.

One important note - after beta testing, I'm planning to clear the test 
database and start from scratch. So, don't go spending too much time 
updating patches!

However, have a play with the new site, let me know what breaks, and any 
suggestions for changing, and we can work towards a full replacement 
for the current site.

Some differences from the old patchwork:

  * Patches can now be 'delegated' to other maintainers - this means
    that maintainers can offload subsystem-specific patches to other
    maintainers.

  * Anyone can create an account, and work with bundles, and manage
    their own patches.

  * Pagination. No more 10MB patch lists!

  * Bundles can be made public, allow users to share patchsets

  * Better filtering interface

Project Maintainers:

  Create an account, then send me your username, and I'll add maintainer
  privileges to your account. Again, don't go too crazy with the   
  maintaining work, as it'll all be cleared out once we replace 
  patchwork.ozlabs.org

  Also: bazaar-ng, linux-mtd and linux-embedded folks: are you still
  using patchwork?

Existing patches:

  After talking to the powerpc maintainers, we've decided that we're
  going to start with a clean slate, and not import patches from the
  existing patchwork database. If you'd prefer to keep current patches
  for your project, let me know. This will be a bit of work, but I'm
  sure we can work something out.

Happy patchworking,


Jeremy
