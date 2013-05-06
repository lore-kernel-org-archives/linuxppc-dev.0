Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F30D02C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 07:41:14 +1000 (EST)
Message-ID: <1367876461.15842.66.camel@pasglop>
Subject: Re: [PATCH v2 1/4] powerpc/cputable: reserve bits in HWCAP2 for new
 features
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ryan Arnold <ryanarn@us.ibm.com>
Date: Tue, 07 May 2013 07:41:01 +1000
In-Reply-To: <OFA8304853.25190807-ON86257B63.0067EDA3-86257B63.00690C34@us.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>
 <OFA8304853.25190807-ON86257B63.0067EDA3-86257B63.00690C34@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael R Meissner <mrmeissn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-06 at 14:07 -0500, Ryan Arnold wrote:
> Notice that I changed DSCR to DSC.  The 'R' wasn't descriptive.

The "R" is the name of the register for which we are exposing the
availability to userspace... it's also the name of the sysfs entry so
I'd rather keep it for consistency.

Cheers,
Ben.
