Return-Path: <marcelo@kvack.org>
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by ozlabs.org (Postfix) with ESMTP id 1F448DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Feb 2008 02:21:31 +1100 (EST)
From: Marcelo Tosatti <marcelo@kvack.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] m8xx_pcmcia: remove unused CONFIG_ variables
Message-ID: <20070719160705.GA2859@dmt>
References: <Pine.LNX.4.64.0707111932060.30119@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0707111932060.30119@localhost.localdomain>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Date: Wed, 27 Feb 2008 15:21:33 -0000



Remove obsolete CONFIG_ usage in m8xx_pcmcia.c. 

Please apply.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
index 9721ed7..37e0b56 100644
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -84,12 +84,6 @@ #define CONFIG_PCMCIA_SLOT_B
 #define CONFIG_BD_IS_MHZ
 #endif
 
-/* The ADS board use SLOT_A */
-#ifdef CONFIG_ADS
-#define CONFIG_PCMCIA_SLOT_A
-#define CONFIG_BD_IS_MHZ
-#endif
-
 /* The FADS series are a mess */
 #ifdef CONFIG_FADS
 #if defined(CONFIG_MPC860T) || defined(CONFIG_MPC860) || defined(CONFIG_MPC821)
@@ -104,12 +98,6 @@ #define CONFIG_PCMCIA_SLOT_A
 #define PCMCIA_GLITCHY_CD
 #endif
 
-/* Cyclades ACS uses both slots */
-#ifdef CONFIG_PRxK
-#define CONFIG_PCMCIA_SLOT_A
-#define CONFIG_PCMCIA_SLOT_B
-#endif
-
 #endif /* !defined(CONFIG_PCMCIA_SLOT_A) && !defined(CONFIG_PCMCIA_SLOT_B) */
 
 #if defined(CONFIG_PCMCIA_SLOT_A) && defined(CONFIG_PCMCIA_SLOT_B)
