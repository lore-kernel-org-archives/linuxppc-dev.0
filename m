Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5F27679F4
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 11:23:52 +1000 (EST)
In-Reply-To: <20060405102837.66b44c43.sfr@canb.auug.org.au>
References: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org>
	<20060405102837.66b44c43.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1E1C6A02-5C4D-4A3A-8483-8D5E2773680B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Tue, 4 Apr 2006 20:23:23 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 4, 2006, at 7:28 PM, Stephen Rothwell wrote:

> On Tue, 4 Apr 2006 16:14:04 -0500 (CDT) Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> Please pull from 'for_paulus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
>>
>> to receive the following updates:
>>
>>  arch/powerpc/configs/mpc85xx_cds_defconfig |  846 ++++++++++++++++ 
>> +++++++++++++
>>  arch/powerpc/kernel/ppc_ksyms.c            |    1
>>  arch/powerpc/platforms/85xx/Kconfig        |    9
>>  arch/powerpc/platforms/85xx/Makefile       |    1
>>  arch/powerpc/platforms/85xx/mpc85xx_cds.c  |  359 ++++++++++++
>>  arch/powerpc/platforms/85xx/mpc85xx_cds.h  |   43 +
>>  arch/ppc/kernel/ppc_ksyms.c                |    1
>>  include/asm-ppc/mpc85xx.h                  |    3
>>  8 files changed, 1262 insertions(+), 1 deletion(-)
>>
>> Andy Fleming:
>>       Add 85xx CDS to arch/powerpc
>
> Could these "add xxx to arch/powerpc" patches please move any relevant
> headers files to include/asm-powerpc as well.  It would be nice if we
> could remove the hack from the powerpc Makefile that include files  
> from
> include/asm-ppc.  i.e. My opinion is that if any ARCH=powerpc build
> requires a file in include/asm-ppc, then that file should be moved to
> include/asm-powerpc.  I am doing a set of patches to that effect.

We need the irq rework before I'd be willing to do this.  The main  
dependancy between asm-ppc and asm-powerpc is the static IRQs we  
currently have.  I'd rather spend time on fixing up the IRQ handling  
to parse the flat dev tree.

- kumar
