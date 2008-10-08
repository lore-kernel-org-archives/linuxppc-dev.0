Return-Path: <davej@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 633C4DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 10:33:18 +1100 (EST)
Date: Wed, 8 Oct 2008 19:33:06 -0400
From: Dave Jones <davej@redhat.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: fsl_upm compile failure.
Message-ID: <20081008233306.GA31771@redhat.com>
References: <20081008222815.GA20542@redhat.com>
	<20081008230219.GA8075@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081008230219.GA8075@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 03:02:19AM +0400, Anton Vorontsov wrote:
 > Hi,
 > 
 > On Wed, Oct 08, 2008 at 06:28:15PM -0400, Dave Jones wrote:
 > > Hi Anton, 
 > >  I tried reenabling CONFIG_MTD_NAND_FSL_UPM in the Fedora kernel
 > > today (currently on 2.6.27-rc9-git1), and got the error below.
 > > 
 > > ERROR: "fsl_lbc_lock" [drivers/mtd/nand/fsl_upm.ko] undefined!
 > 
 > Weird. It works for me with mpc836x_rdk_defconfig and
 > MTD_NAND_FSL_UPM=m...
 > 
 > Hm..
 > 
 >   CC      drivers/mtd/nand/fsl_upm.mod.o
 >   LD [M]  drivers/mtd/nand/fsl_upm.ko
 > 
 > Can you send me the .config file you use?
 
http://davej.fedorapeople.org/ppc.config

 > But the patch looks obviously correct. Much thanks for catching this.
 > 
 > Though better option would be to uninline the fsl_upm_run_pattern()..
 > it is quite big anyway... Something like this:

I'll leave it to you to decide what to push to Linus

	Dave

-- 
http://www.codemonkey.org.uk
