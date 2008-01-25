Return-Path: <geert@sonycom.com>
Message-Id: <20080125153107.598867093@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Date: Fri, 25 Jan 2008 16:06:34 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 11/11] ps3fb: Fix modedb typos
Sender: geert <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geoff Levand <geoffrey.levand@am.sony.com>

ps3fb: Fix modedb typos

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -184,7 +184,7 @@ static const struct fb_videomode ps3fb_m
         "720p", 50, 1124, 644, 13468, 298, 478, 57, 44, 80, 5,
         FB_SYNC_BROADCAST, FB_VMODE_NONINTERLACED
     },    {
-        /* 1080 */
+        /* 1080i */
         "1080i", 50, 1688, 964, 13468, 264, 600, 94, 62, 88, 5,
         FB_SYNC_BROADCAST, FB_VMODE_INTERLACED
     },    {
@@ -232,7 +232,7 @@ static const struct fb_videomode ps3fb_m
 	FB_SYNC_BROADCAST, FB_VMODE_NONINTERLACED
     }, {
 	/* 1080if */
-	"1080f", 50, 1920, 1080, 13468, 148, 484, 36, 4, 88, 5,
+	"1080if", 50, 1920, 1080, 13468, 148, 484, 36, 4, 88, 5,
 	FB_SYNC_BROADCAST, FB_VMODE_INTERLACED
     }, {
 	/* 1080pf */

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
