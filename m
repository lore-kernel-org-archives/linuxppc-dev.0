Return-Path: <christophe.alayrac@cresitt.com>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by ozlabs.org (Postfix) with ESMTP id AF697DDD08
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 02:06:05 +1100 (EST)
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by postfix1-g20.free.fr (Postfix) with ESMTP id EA89AB6A336
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 16:06:03 +0100 (CET)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>,
	"'Ed Swierk'" <eswierk@arastra.com>
Subject: RE : Serial console not working on EP8343M
Date: Tue, 13 Mar 2007 16:05:49 +0100
Message-ID: <000d01c76581$17a89820$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <8BE4BF8E-A32E-4984-9B1B-C3B6ED2A1BCA@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

I don't really know if i twill help you but I face the same problem some
times ago with Linux 2.6.17.4 and Linux 2.6.19.7.
I fixe the console error just by manually creating the node /dev/console
in the root file system to be mounted.

This device was automatically generated when I was using Linux-2.4.26.

I guess it help

Chris
