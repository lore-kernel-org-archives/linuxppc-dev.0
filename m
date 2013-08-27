Return-Path: <gleb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 6B6AE2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 16:40:33 +1000 (EST)
Date: Tue, 27 Aug 2013 09:40:26 +0300
From: Gleb Natapov <gleb@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/10] KVM: PPC: reserve a capability number for multitce
 support
Message-ID: <20130827064026.GB22899@redhat.com>
References: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
 <1375332272-22176-3-git-send-email-aik@ozlabs.ru>
 <1376441474.4255.39.camel@pasglop>
 <20130826123753.GA22977@redhat.com>
 <1377577198.3819.102.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377577198.3819.102.camel@pasglop>
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

On Tue, Aug 27, 2013 at 02:19:58PM +1000, Benjamin Herrenschmidt wrote:
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
> 
Queue will become next after I will test it and if test will fail the
commit hash may change, but since you are going to cherry-pick and this
does not preserve commit hash it does not matter.

--
			Gleb.
