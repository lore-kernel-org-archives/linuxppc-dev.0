Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A4E032C0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 15:18:44 +1000 (EST)
Message-ID: <1347254311.11820.0.camel@pasglop>
Subject: Re: [powerpc:next 60/78]
 arch/powerpc/platforms/pseries/eeh_pe.c:217:23: error: 'eeh_pe_get' defined
 but not used
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 10 Sep 2012 15:18:31 +1000
In-Reply-To: <20120910025121.GB1572@shangw.(null)>
References: <20120910023442.GB29863@localhost>
 <20120910025121.GB1572@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Fengguang Wu <fengguang.wu@intel.com>,
 kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-10 at 10:51 +0800, Gavin Shan wrote:
> >
> 
> The global functions eeh_pe_get() and eeh_pe_get_parent() will be used
> by subsequent patches. I think ppc/next merged 23 patches for EEH core
> this time. I'm not sure I should refactor those patches to avoid the
> build failure? :-)

No, don't bother, it's a case where gcc warnings are a bit too zealous.
Next time we'll try to avoid it but for now, I won't rebase.

Cheers,
Ben.
