Return-Path: <apgo@patchbomb.org>
Received: from mail22.bluewin.ch (mail22.bluewin.ch [195.186.19.66])
	by ozlabs.org (Postfix) with ESMTP id 4E6F3688E6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 06:17:04 +1100 (EST)
Date: Wed, 18 Jan 2006 13:53:57 -0500
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: [PATCH] powerpc: replace linuxppc64.org references with
	penguinppc.org/ppc64/
Message-ID: <20060118185357.GA32191@krypton>
References: <20060116121244.GB7171@suse.de> <20060118110905.GA23678@krypton>
	<20060118120715.GB19765@suse.de>
	<1137599288.10689.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137599288.10689.2.camel@localhost.localdomain>
From: apgo@patchbomb.org (Arthur Othieno)
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 18, 2006 at 09:48:08AM -0600, Hollis Blanchard wrote:
> On Wed, 2006-01-18 at 13:07 +0100, Olaf Hering wrote:
> >  On Wed, Jan 18, Arthur Othieno wrote:
> > 
> > > What about the s/linuxppc64\.org/penguinppc\.org/g case? Or is
> > > penguinppc64.org preferable? Or am I just taking it too far? ;)
> > 
> > They are redirected on DNS or HTTP level.
> 
> HTTP level, but that doesn't answer his question.
> 
> As the maintainer of that site, I would prefer to remove the
> linuxppc64.org reference.
 
[PATCH] powerpc: replace linuxppc64.org references with penguinppc.org/ppc64/

http://www.penguinppc.org/ppc64/ is the canonical URL for all things ppc64.
http://linuxppc64.org is just a redirect so update all references accordingly.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

Depends on Olaf's: [PATCH] drop linuxppc64-dev


 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

07edae4fcd285140c92dc32229043af1429196ce
diff --git a/MAINTAINERS b/MAINTAINERS
index 3283304..18dcfb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -535,7 +535,7 @@ BROADBAND PROCESSOR ARCHITECTURE
 P:	Arnd Bergmann
 M:	arnd@arndb.de
 L:	linuxppc-dev@ozlabs.org
-W:	http://linuxppc64.org
+W:	http://www.penguinppc.org/ppc64/
 S:	Supported
 
 BTTV VIDEO4LINUX DRIVER
@@ -1608,7 +1608,7 @@ M:	paulus@au.ibm.com
 P:	Anton Blanchard
 M:	anton@samba.org
 M:	anton@au.ibm.com
-W:	http://linuxppc64.org
+W:	http://www.penguinppc.org/ppc64/
 L:	linuxppc-dev@ozlabs.org
 S:	Supported
 
-- 
1.0.0b
