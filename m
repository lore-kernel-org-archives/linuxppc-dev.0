Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com
 [IPv6:2607:f8b0:4003:c06::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 518991A0A23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 05:05:09 +1100 (AEDT)
Received: by mail-oi0-f51.google.com with SMTP id h136so3528156oig.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 10:05:05 -0800 (PST)
Date: Tue, 13 Jan 2015 11:05:02 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V10 00/17] Enable SRIOV on Power8
Message-ID: <20150113180502.GC2776@google.com>
References: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141222060522.GA12285@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222060522.GA12285@richard>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 22, 2014 at 02:05:22PM +0800, Wei Yang wrote:
> Bjorn,
> 
> This patch set is tested on 3.19-rc1 and with the offset/stride update patch.
> 
> I see your comment on the MEM64 issue, so if that is reverted, this
> patch set will not work. While I think we can work in parallel, I sent it here
> for more comment and to see whether I understand your previous comments
> correctly.
> 
> I will work with Yinghai to find a way to fix the bug 85491, hope linux kernel
> could handle both cases.

OK.  The autobuilder found some minor issues, so I'll look for a v11
posting that fixes those.  Please pick up the changelogs from my
pci/virtualization branch because I rewrapped them so they fit in 80
columns when shown by "git log".

Bjorn
