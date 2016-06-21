Return-Path: <Vineet.Gupta1@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.47.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYbsx11xRzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 15:30:45 +1000 (AEST)
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Alexandru Moise <00moses.alexander00@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "bamvor.zhangjian@linaro.org" <bamvor.zhangjian@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] devpts: remove DEVPTS_MULTIPLE_INSTANCES from all configs
Date: Tue, 21 Jun 2016 05:30:40 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750106944A83@us01wembx1.internal.synopsys.com>
References: <20160620091258.11233-1-00moses.alexander00@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 20 June 2016 02:44 PM, Alexandru Moise wrote:=0A=
> As each mount of devpts is now an independent filesystem,=0A=
> the DEVPTS_MULTIPLE_INSTANCES config option no longer exists.=0A=
> So remove it.=0A=
>=0A=
> Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>=0A=
=0A=
For arch/arc=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
