Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblFp2G27zDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:11:58 +1100 (AEDT)
In-Reply-To: <20170626140601.7106-2-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Suchanek <msuchanek@suse.de>,
 Colin Ian King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [2/2] powerpc/fadump: use kstrtoint to handle sysfs store
Message-Id: <3yblFp1Dmrz9sPr@ozlabs.org>
Date: Tue, 14 Nov 2017 22:11:58 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-06-26 at 14:06:01 UTC, Michal Suchanek wrote:
> Currently sysfs store handlers in fadump use if buf[0] == 'char'.
> 
> This means input "100foo" is interpreted as '1' and "01" as '0'.
> 
> Change to kstrtoint so leading zeroes and the like is handled in
> expected way.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Acked-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Signed-off-by: Michal Suchanek <a class="moz-txt-link-rfc2396E" href="mailto:msuchanek@suse.de">&lt;msuchanek@suse.de&gt;</a></pre>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dcdc46794b7bb76733d9792cca2f45

cheers
