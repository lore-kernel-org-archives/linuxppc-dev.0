Return-Path: <seh@zee2.com>
Subject: Re: [Ltib] ltib error -linux2.6.20.6 with MPC8360E MDS
From: Stuart Hughes <seh@zee2.com>
To: nanda <nanda74pg@rediffmail.com>
In-Reply-To: <20081120183038.10714.qmail@f5mail-236-234.rediffmail.com>
References: <20081120183038.10714.qmail@f5mail-236-234.rediffmail.com>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 18:40:36 +0000
Message-Id: <1227206436.28157.353.camel@m20>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org, Ltib@nongnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nanda,

This is happening because you don't have access to
http://www.bitshrine.org/gpp for some reason.

If LTIB needs to download sources to build a package, it will get them
from bitshrine.org.  Can you check that you are able to access this URL
from the command line with wget.

Regards, Stuart

On Thu, 2008-11-20 at 18:30 +0000, nanda wrote:
> Hi All,
>    Iam forwarding the mail which I have posted to powerpc linux list
>  Linuxppc-dev@ozlabs.org
> ===================================================
> 
>   Iam getting the below error during the generation of
> rootfs.ext2.gz.uboot (Power PC Linux RAM Disk Image) and uImage (Power
> PC Linux Kernel Image) for linux-2.6.20.6 kernel on the power PC MPC
> 8360E MDS using ltib tool.
> 
> "Testing ppp_url connectivity: FAIL, disabling 
> 
> Testing gpp_url connectivity: FAIL, disabling 
> 
> No network download connection available"
> 
> I did the following steps, but Iam unable to generate the
> rootfs.ext2.gz.uboot 
> 
> - In the ltib directory 
> 
> ./ltib --configure
> 
> In the configure menu, I specified the following, before saving the
> configs
> 
> - Tool chain as (gcc-3.4.3/glibc-2.3.3)
> 
> - uboot 1.1.3
> 
> - "Kernel (local linux directory build)" which refers to the local
> directory where linux-2.6.20.6 is placed
> 
> - "Kernel config file"specified as mpc8360emds_defconfig, which is the
> file copied
> from /home/nanda/linux2.6.20.6/arch/powerpc/configs/mpc8360emds_defconfig to the ltib/config/platform/mpc8360epb directory) 
> 
> - Linux Target Architecture as "powerpc"
> 
> After the above process by saving the configuration (it started
> building kernel and generated uImage) and failed in the below place
> (Refer also the attached build.txt file)
> 
> ================================
> 
> Processing: skell 
> 
> =================== 
> 
> Testing ppp_url connectivity: FAIL, disabling 
> 
> Testing gpp_url connectivity: FAIL, disabling 
> 
> No network download connection available
> 
> Started: Thu Nov 20 14:44:45 2008 
> 
> Ended: Thu Nov 20 14:57:32 2008 
> 
> Elapsed: 767 seconds 
> 
> Build Failed
> 
> =====================================
> 
> I have attached the below files for boot and build logs with this
> mail, 
> 
> 1) defconfig.dev - default config generated for "./ltib configure"
> from config/platform/mpc8360epb 
> 
> 2) build.txt - Error build during "./ltib configure" output
> 
> 3) mpc8360emds_defconfig - Default config file
> from /home/nanda/linux2.6.20.6/arch/powerpc/configs/ 
> 
> The end result was I could only see the uImage generated without
> rootfs.ext2.gz.uboot. Please clarify on the same 
> 
> Thanks in advance,
> 
> Regards,
> 
> Nanda
> 
