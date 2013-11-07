Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 645142C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 18:55:21 +1100 (EST)
Message-ID: <1383810909.4776.171.camel@pasglop>
Subject: Re: [PATCH 3/3] powerpc/kvm: remove redundant assignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 07 Nov 2013 18:55:09 +1100
In-Reply-To: <92DFDE0F-0E72-41F9-9562-3EC0CA5BD2B1@suse.de>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
 <740542A8-47BC-4015-8675-D36C72F5837D@suse.de>
 <1383767930.4776.125.camel@pasglop>
 <92DFDE0F-0E72-41F9-9562-3EC0CA5BD2B1@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Liu Ping Fan <kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-07 at 08:52 +0100, Alexander Graf wrote:
> Am 06.11.2013 um 20:58 schrieb Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> 
> > On Wed, 2013-11-06 at 12:24 +0100, Alexander Graf wrote:
> >> On 05.11.2013, at 08:42, Liu Ping Fan <kernelfans@gmail.com> wrote:
> >> 
> >>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> >> 
> >> Patch description missing.
> > 
> > Do you really need a description for trivial one-lines whose subject
> > is a perfectly complete description already ?
> 
> Would I ask for it otherwise? It's also not 100% obvious that the assignment is redundant.

And ? An explanation isn't going to be clearer than the code in that
case ...

Ben.
