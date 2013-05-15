Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7FB0E2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 15:59:07 +1000 (EST)
Message-ID: <1368597537.31689.70.camel@pasglop>
Subject: Re: [PATCH v1 00/22] powerpc/eeh: Enhance converting EEH dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 15 May 2013 15:58:57 +1000
In-Reply-To: <20130515053049.GA28780@shangw.(null)>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1368590264.31689.69.camel@pasglop> <20130515053049.GA28780@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-15 at 13:30 +0800, Gavin Shan wrote:
> >There is an error injection framework we can use nowadays, or maybe you can
> >put this in tools/powerpc ?
> >
> 
> Ben, we don't have error injection framework yet. I have one source file "eeh-debug.c"
> which exports P7IOC registers through procfs. In order to force EEH errors (frozen PE
> or fenced PHB), we need change the specific bits of corresponding HW registers through
> the procfs entries (e.g. /proc/IODA/PHBx/REG).

I mean Linux has an error injection framework :-) We could hook up something into it.

Cheers,
Ben.
