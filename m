Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id D317CDDE46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 09:05:52 +1100 (EST)
Date: Tue, 29 Jan 2008 14:05:41 -0800
Subject: Haleakala Defconfg
From: Grant Erickson <gerickson@nuovations.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Message-ID: <C3C4E335.D193%gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is there a patch pending to for 'arch/powerpc/configs/haleakala_defconfig'?
I did not see one in either of:

    git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
    git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

If no patch is pending, to whom do I submit such a patch? It'll simply be a
near clone of 'kilauea_defconfig', save the "CONFIG_DEVICE_TREE" entry.

Regards,

Grant Erickson
