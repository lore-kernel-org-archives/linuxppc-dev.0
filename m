Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 155E42C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 16:14:45 +1100 (EST)
Message-ID: <5142AE27.7060003@asianux.com>
Date: Fri, 15 Mar 2013 13:14:15 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [Suggestion] PowerPC: kernel: cross compiling issue with
 allmodconfig
References: <51428C81.6000204@asianux.com>
 <25841.1363323174@ale.ozlabs.ibm.com>
In-Reply-To: <25841.1363323174@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, matt@ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013年03月15日 12:52, Michael Neuling 写道:
> Yep it's a known problem but no one has bothered to fix it since it
> doesn't happen in a config that anyone cares about like
> pseries_defconfig and ppc64_defconfig.  We've been moving code around in
> this area a lot recently hence the breakage.
> 
> It should be fixed though.  Patches welcome. :-)

  thanks, and I should try, and very glad to try.

  :-)  :-)

  excuse me, I try to provide related patch within this month (2013-03-31), is it ok ?
  the reason is:
    I am not familiar with ppc assembly code, neither ppc kernel,
    so need additional time resource.
      (originally, I worked for x86(_64) core dump analysing for kernel and user programs)

  thanks.

-- 
Chen Gang

Asianux Corporation
