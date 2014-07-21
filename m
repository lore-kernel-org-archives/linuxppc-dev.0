Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC9071A0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 08:49:20 +1000 (EST)
Message-ID: <1405982949.5289.217.camel@pasglop>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Date: Tue, 22 Jul 2014 08:49:09 +1000
In-Reply-To: <53CCCA09.1060404@linux.vnet.ibm.com>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <53A91819.1010900@linux.vnet.ibm.com> <1403591761.4587.161.camel@pasglop>
 <53A9216C.8050904@linux.vnet.ibm.com> <1403593252.4587.163.camel@pasglop>
 <20140625000305.GA5742@shangw> <53AA3C5C.4080807@linux.vnet.ibm.com>
 <1403666349.4587.196.camel@pasglop> <53CCCA09.1060404@linux.vnet.ibm.com>
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

On Mon, 2014-07-21 at 16:06 +0800, Mike Qiu wrote:
> > I don't like this. I much prefer have dedicated error injection files
> > in their respective locations, something for PCI under the corresponding
> > PCI bridge etc...
> 
> So PowerNV error injection will be designed rely on debugfs been 
> configured, right?

Not necessarily. If we create a better debugfs layout for our PHBs, then
yes. It might be useful to provide more info in there for example access
to some of the counters ...

But on the other hand, for error injection in general, I wonder if we should
be under sysfs instead... something to study a bit.

Cheers,
Ben.
