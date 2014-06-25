Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 343051A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 13:19:21 +1000 (EST)
Message-ID: <1403666349.4587.196.camel@pasglop>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Date: Wed, 25 Jun 2014 13:19:09 +1000
In-Reply-To: <53AA3C5C.4080807@linux.vnet.ibm.com>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <53A91819.1010900@linux.vnet.ibm.com> <1403591761.4587.161.camel@pasglop>
 <53A9216C.8050904@linux.vnet.ibm.com> <1403593252.4587.163.camel@pasglop>
 <20140625000305.GA5742@shangw> <53AA3C5C.4080807@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-25 at 11:05 +0800, Mike Qiu wrote:
> Here maybe  "/sys/kernel/debug/powerpc/errinjct" is better, because
> it 
> will supply "PCI_domain_nr" in parameters, so no need supply errinjct 
> for each PCI domain.
> 
> Another reason is error inject not only for PCI(in future), so better 
> not in PCI domain entry.
> 
> Also it simple for userland tools to has a fixed path.

I don't like this. I much prefer have dedicated error injection files
in their respective locations, something for PCI under the corresponding
PCI bridge etc...

Cheers,
Ben.
