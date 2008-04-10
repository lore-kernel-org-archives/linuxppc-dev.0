Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B5CDDDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:07:44 +1000 (EST)
Date: Thu, 10 Apr 2008 20:07:30 +0900 (JST)
Message-Id: <20080410.200730.-1300529759.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: Re: Patches added to powerpc.git powerpc-next and master branches
In-Reply-To: <18425.46732.651483.504040@cargo.ozlabs.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> wrote:
> The following patches have been added to the master and powerpc-next
> branches of the powerpc.git repository.  There is a bunch that I

Paul-san,
Could you apply my "take 2" patchset?

[PATCH 0/11] celleb: patchset for 2.6.26 (take 2)
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052989.html

[PATCH 1/11] celleb: coding style cleanup
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052990.html

[PATCH 2/11] cell: generalize io-workarounds code
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052991.html

[PATCH 3/11] celleb: consolidate io-workarounds code
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052992.html

[PATCH 4/11] celleb: move the base part for celleb support
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052993.html

[PATCH 5/11] celleb: move the SCC related code for celleb
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052994.html

[PATCH 6/11] celleb: move files for Beat hvcall interfaces
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052995.html

[PATCH 7/11] celleb: move files for Beat mmu and iommu
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052996.html

[PATCH 8/11] celleb: move a file for SPU on Beat
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052997.html

[PATCH 9/11] celleb: move miscellaneous files for Beat
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052998.html

[PATCH 10/11] celleb: add support for PCI Express
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052999.html

[PATCH 11/11] hvcbeat: fix buffer manipulation
 http://ozlabs.org/pipermail/linuxppc-dev/2008-March/053025.html

Best regards,
Kou Ishizaki
