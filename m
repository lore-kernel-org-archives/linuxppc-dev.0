Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7F3C1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 21:35:16 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9EAIYK1017183
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 06:18:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9EAZBiI338066
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 06:35:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9EAZBH1009092
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 07:35:11 -0300
Date: Thu, 14 Oct 2010 06:35:10 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Please pull 'next' branch of 4xx tree
Message-ID: <20101014103510.GA6227@zod.rchland.ibm.com>
References: <20100928130941.GA31993@zod.rchland.ibm.com>
	<20101013131608.GA6154@zod.rchland.ibm.com>
	<1287017775.2205.49.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287017775.2205.49.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 14, 2010 at 11:56:15AM +1100, Benjamin Herrenschmidt wrote:
>On Wed, 2010-10-13 at 09:16 -0400, Josh Boyer wrote:
>> On Tue, Sep 28, 2010 at 09:09:41AM -0400, Josh Boyer wrote:
>> >Hi Ben,
>> >
>> >A few small updates for the next branch.  A new board/SoC from AMCC, and
>> >some 476 changes from Shaggy.  Please pull.
>> 
>> OK, below is a fixed up tree that drops the patch Shaggy said was
>> broken, and rebases on top of your new -next branch.  Please pull.
>
>please, rebase again without Shaggy's lazy flush patch. I'll handle that
>one separately, I think it needs a little bit more massaging.

The following changes since commit 4108d9ba9091c55cfb968d42dd7dcae9a098b876:

  powerpc/Makefiles: Change to new flag variables (2010-10-13 16:19:22 +1100)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Josh Boyer (1):
      powerpc/44x: Update ppc44x_defconfig

Tirumala Marri (1):
      powerpc/44x: Add support for the AMCC APM821xx SoC

 arch/powerpc/boot/dts/bluestone.dts          |  254 ++++++++++++++++++++++++++
 arch/powerpc/configs/44x/bluestone_defconfig |   68 +++++++
 arch/powerpc/configs/ppc44x_defconfig        |    9 +-
 arch/powerpc/kernel/cpu_setup_44x.S          |    1 +
 arch/powerpc/kernel/cputable.c               |   15 ++
 arch/powerpc/platforms/44x/Kconfig           |   16 ++
 arch/powerpc/platforms/44x/ppc44x_simple.c   |    1 +
 7 files changed, 360 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/bluestone.dts
 create mode 100644 arch/powerpc/configs/44x/bluestone_defconfig
