Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90C9A47676
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 11:19:24 +1100 (EST)
Message-Id: <EF2AAE7D-E419-4DD6-8097-98AEF74795A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090108215539.GA6183@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v6 1/2] powerpc/fsl_pci: Add MPC83xx PCI-E controller RC
	mode support
Date: Thu, 8 Jan 2009 18:17:13 -0600
References: <20090108013006.GA31653@oksana.dev.rtsoft.ru>
	<20090108013110.GA11165@oksana.dev.rtsoft.ru>
	<C65915E8-6544-4229-9ED2-D2BB936D537C@kernel.crashing.org>
	<20090108191021.GA10008@oksana.dev.rtsoft.ru>
	<44A459AC-796C-4928-A39E-88F6F6DF159E@kernel.crashing.org>
	<20090108215539.GA6183@oksana.dev.rtsoft.ru>
Cc: Huang Changming <Chang-Ming.Huang@freescale.com>,
	Liu Dave <DaveLiu@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 8, 2009, at 3:55 PM, Anton Vorontsov wrote:

> This patch adds support for PCI-Express controllers as found on the
> newer MPC83xx chips.
>
> The work is loosely based on the Tony Li's patch[1], but unlike the
> original patch, this patch implements sliding window for the Type 1
> transactions using outbound window translations, so we don't have to
> ioremap the whole PCI-E configuration space.
>
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-January/049028.html
>
> Signed-off-by: Tony Li <tony.li@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> On Thu, Jan 08, 2009 at 01:24:27PM -0600, Kumar Gala wrote:
> [...]
>> I'm ok if you get rid of cfg_data usage.. than we aren't  
>> overloading the
>> indirect variables for 83xx pci cfg cycles
>
> Here it is.
>
> Thanks,
>
> arch/powerpc/sysdev/fsl_pci.c |  244 ++++++++++++++++++++++++++++++++ 
> +++++----
> include/linux/pci_ids.h       |    8 ++
> 2 files changed, 228 insertions(+), 24 deletions(-)

applied

- k
