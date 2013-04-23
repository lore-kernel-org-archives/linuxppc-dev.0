Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Apr 2013 21:30:11 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Chen Yuanquan-B41889 <B41889@freescale.com>
Subject: Re: [PATCH] powerpc/pci: fix PCI-e devices rescan issue on powerpc
 platform
Message-ID: <20130423113011.GA27200@concordia>
References: <1364902014-943-1-git-send-email-Yuanquan.Chen@freescale.com>
 <1364915422.16520.8.camel@pasglop> <515BAB44.9070001@freescale.com>
 <51652C20.2060105@freescale.com> <517653D8.8000205@freescale.com>
 <1366711520.2886.24.camel@pasglop> <5176679D.7090008@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5176679D.7090008@freescale.com>
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 06:51:09PM +0800, Chen Yuanquan-B41889 wrote:
> On 04/23/2013 06:05 PM, Benjamin Herrenschmidt wrote:
> >On Tue, 2013-04-23 at 17:26 +0800, Chen Yuanquan-B41889 wrote:
> >>There's no response from Ben. How do you think about this patch?
> >>What's
> >>your advice?
> >Didn't Michael put your patch in -next while I was on vacation ? I'll
> >check tomorrow.
> >
> >Cheers,
> >Ben.
> >
> 
> Hi Ben,
> 
> I have checked the latest kernel(v3.9-rc7). This patch has been applied.

No it's not in v3.9-rc7.

It is in my test branch, which is in linux-next.

http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit?id=37f02195bee9c25ce44e25204f40b7961a6d7c9d

cheers
