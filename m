Return-Path: <kevcorry@us.ibm.com>
From: Kevin Corry <kevcorry@us.ibm.com>
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC,PATCH 2/2] Oprofile-on-Cell prereqs: Export hrtimer_forward
Date: Thu, 9 Nov 2006 09:02:39 -0600
References: <200611090858.11590.kevcorry@us.ibm.com>
In-Reply-To: <200611090858.11590.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611090902.39714.kevcorry@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a symbol-export for kernel/hrtimer.c::hrtimer_forward(). This routine
is needed by the upcoming Oprofile-for-Cell patches, since Oprofile can
be built as a module.

Signed-Off-By: Kevin Corry <kevcorry@us.ibm.com>

Index: linux-2.6.18-arnd5/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-arnd5.orig/kernel/hrtimer.c
+++ linux-2.6.18-arnd5/kernel/hrtimer.c
@@ -335,6 +335,7 @@ hrtimer_forward(struct hrtimer *timer, k
 
 	return orun;
 }
+EXPORT_SYMBOL_GPL(hrtimer_forward);
 
 /*
  * enqueue_hrtimer - internal function to (re)start a timer
