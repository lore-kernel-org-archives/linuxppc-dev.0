Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A768D2C013C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 20:05:35 +1000 (EST)
Message-ID: <1366711520.2886.24.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: fix PCI-e devices rescan issue on powerpc
 platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Yuanquan-B41889 <B41889@freescale.com>
Date: Tue, 23 Apr 2013 20:05:20 +1000
In-Reply-To: <517653D8.8000205@freescale.com>
References: <1364902014-943-1-git-send-email-Yuanquan.Chen@freescale.com>
 <1364915422.16520.8.camel@pasglop> <515BAB44.9070001@freescale.com>
 <51652C20.2060105@freescale.com> <517653D8.8000205@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-23 at 17:26 +0800, Chen Yuanquan-B41889 wrote:
> There's no response from Ben. How do you think about this patch?
> What's 
> your advice?

Didn't Michael put your patch in -next while I was on vacation ? I'll
check tomorrow.

Cheers,
Ben.
