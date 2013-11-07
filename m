Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 924DD2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 19:36:42 +1100 (EST)
Message-ID: <1383813364.4776.172.camel@pasglop>
Subject: Re: [PATCH 3/3] powerpc/kvm: remove redundant assignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 07 Nov 2013 19:36:04 +1100
In-Reply-To: <D41E9B02-613E-498D-B68B-18FCAC21637F@suse.de>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
 <740542A8-47BC-4015-8675-D36C72F5837D@suse.de>
 <1383767930.4776.125.camel@pasglop>
 <92DFDE0F-0E72-41F9-9562-3EC0CA5BD2B1@suse.de>
 <1383810909.4776.171.camel@pasglop>
 <D41E9B02-613E-498D-B68B-18FCAC21637F@suse.de>
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

On Thu, 2013-11-07 at 09:14 +0100, Alexander Graf wrote:
> > And ? An explanation isn't going to be clearer than the code in that
> > case ...
> 
> It's pretty non-obvious when you do a git show on that patch in 1 year
> from now, as the redundancy is out of scope of what the diff shows.

And ? How would an explanation help ?

Either it's redundant or it's not ... but only look at the code can
prove it. An explanation won't because if the patch is wrong, so will be
the explanation.

Cheers,
Ben.
