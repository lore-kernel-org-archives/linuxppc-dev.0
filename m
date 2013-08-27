Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 849902C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 14:22:52 +1000 (EST)
Message-ID: <1377577362.3819.103.camel@pasglop>
Subject: Re: [PATCH 02/10] KVM: PPC: reserve a capability number for
 multitce support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gleb Natapov <gleb@redhat.com>
Date: Tue, 27 Aug 2013 14:22:42 +1000
In-Reply-To: <1377577198.3819.102.camel@pasglop>
References: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
 <1375332272-22176-3-git-send-email-aik@ozlabs.ru>
 <1376441474.4255.39.camel@pasglop> <20130826123753.GA22977@redhat.com>
 <1377577198.3819.102.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-27 at 14:19 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-08-26 at 15:37 +0300, Gleb Natapov wrote:
> > > Gleb, any chance you can put this (and the next one) into a tree to
> > > "lock in" the numbers ?
> > > 
> > Applied it. Sorry for slow response, was on vocation and still go
> > through the email backlog.
> 
> Thanks. Since it's not in a topic branch that I can pull, I'm going to
> just cherry-pick them. However, they are in your "queue" branch, not
> "next" branch. Should I still assume this is a stable branch and that
> the numbers aren't going to change ?

Oh and Alexey mentions that there are two capabilities and you only
applied one :-)

Cheers,
Ben.
