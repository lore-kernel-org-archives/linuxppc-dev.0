Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT9Vf1F8wzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 20:28:26 +1100 (AEDT)
Message-ID: <1458552497.7374.1.camel@ellerman.id.au>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.6-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Igal.Liberman@freescale.com, Zhiqiang.Hou@freescale.com,
 adam.buchbinder@gmail.com, aik@ozlabs.ru, alessio.bogani@elettra.eu,
 andrew.donnellan@au1.ibm.com, "Aneesh Kumar K. V"
 <aneesh.kumar@linux.vnet.ibm.com>, Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>, Boqun Feng
 <boqun.feng@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
 chenhui.zhao@freescale.com, Christophe Leroy <christophe.leroy@c-s.fr>,
 clombard@linux.vnet.ibm.com, cyrilbur@gmail.com,
 david@gibson.dropbear.id.au,  dongsheng.wang@freescale.com,
 dougmill@linux.vnet.ibm.com, Torsten Duwe <duwe@lst.de>, duwe@suse.de,
 fbarrat@linux.vnet.ibm.com,  gwshan@linux.vnet.ibm.com, Ian Munsie
 <imunsie@au1.ibm.com>, Jeremy Kerr <jk@ozlabs.org>, joel@jms.id.au, "Kirill
 A. Shutemov" <kirill.shutemov@linux.intel.com>, leoyang.li@nxp.com, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev
 <linuxppc-dev@lists.ozlabs.org>,  luis.henriques@canonical.com,
 maddy@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,  Michael Neuling
 <mikey@neuling.org>, mrochs@linux.vnet.ibm.com, oss@buserror.net, Paul
 Mackerras <paulus@ozlabs.org>,  Paul Mackerras <paulus@samba.org>,
 qiang.zhao@nxp.com, raghav.dogra@nxp.com, ruscur@russell.cc,
 saurabh.truth@gmail.com, sjitindarsingh@gmail.com,
 stewart@linux.vnet.ibm.com,  sukadev@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, Richard Yang <weiyang@linux.vnet.ibm.com>,
 xinhui.pan@linux.vnet.ibm.com, xuelin.shi@nxp.com
Date: Mon, 21 Mar 2016 20:28:17 +1100
In-Reply-To: <CA+55aFwcVx5+oaBXqFT=+DPeTOx2xUKGr0nJ6GPpxzf6a5wSwA@mail.gmail.com>
References: <1458302850.10432.2.camel@ellerman.id.au>
 <CA+55aFwcVx5+oaBXqFT=+DPeTOx2xUKGr0nJ6GPpxzf6a5wSwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-03-19 at 15:57 -0700, Linus Torvalds wrote:
> On Fri, Mar 18, 2016 at 5:07 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > I couldn't convince git request-pull to generate a sane diffstat below, it
> > seems to be confused because I merged powerpc-4.5-4 into my next.
>
> Yes, if there are multiple merge bases (particularly cross-merges, but
> you can get it just from internal merges of work that started at
> different points), a plain "git diff" will often be unable to give
> reasonable results.
>
> > So I just did the merge and took that diffstat. Hopefully that makes sense.
>
> Yes, that's the way to get a reliable diff if you have more complex history.

OK.

For some reason I thought git-request-pull had some magic to work out the right
diffstat, but I see now it's just a shell script that does git diff --stat.

> Some people do that merge by default (ie both the networking tree and
> the ARM SoC trees tend to do this), not just to get the reliable diff,
> but also to inform me of the conflicts that they encountered.

Yeah, I have been doing it to check for conflicts, but then throwing it away.
So I'll just change my process to do the test merge and then take the diff stat
for the pull request.

> Basically you should never hit that complicated case unless you are
> already using workflows that means that you can handle it, and by then
> you usually also end up understanding why clean history and avoiding
> back-merges is a good idea etc.
>
> Welcome to that second group.

Thanks.

cheers
