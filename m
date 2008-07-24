Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807232034x3af76073x979ef608ddfbebfb@mail.gmail.com>
Date: Wed, 23 Jul 2008 23:34:28 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: ppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: Getting GPIO to build again
In-Reply-To: <9e4733910807232009o634027cajde78395f95ae95ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910807232009o634027cajde78395f95ae95ce@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This lets me build again, no clue if it is the correct fix.

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 3a7a11a..e14dbe3 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -3,6 +3,7 @@ config OF_DEVICE
        depends on OF && (SPARC || PPC_OF)

 config OF_GPIO
+       select GENERIC_GPIO
        def_bool y
        depends on OF && PPC_OF && HAVE_GPIO_LIB
        help


-- 
Jon Smirl
jonsmirl@gmail.com
