Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7805C1A09F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 10:50:51 +1100 (AEDT)
Message-ID: <1428018637.22867.306.camel@freescale.com>
Subject: Re: [PATCH] powerpc/83xx: add support for mpc8306
From: Scott Wood <scottwood@freescale.com>
To: Filip =?UTF-8?Q?Brozovi=C4=87?= <fbrozovic@gmail.com>
Date: Thu, 2 Apr 2015 18:50:37 -0500
In-Reply-To: <551AFC7E.8090108@gmail.com>
References: <1427561968-32049-1-git-send-email-fbrozovic@gmail.com>
 <1427824493.22867.226.camel@freescale.com> <551AFC7E.8090108@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-31 at 21:58 +0200, Filip Brozović wrote:
> On 3/31/2015 7:54 PM, Scott Wood wrote:
> > This breaks multiplatform support.  You need to determine this at
> > runtime.
> 
> Understood, but I'm unsure of how to do this exactly. Would it be 
> appropriate to define another array, snum_init_14, with the SNUM values 
> for the MPC8306 QE, change the minimum number of SNUMs in 
> qe_get_num_of_snums() to 14 and set the correct values this way? In that 
> case, compatibility with other platforms would be kept intact, and the 
> QE device tree node for MPC8306 (and MPC8309) boards would just have to 
> have the fsl,qe-num-snums property set to 14 in order for the driver to 
> set the correct values.

Yes.

-Scott
