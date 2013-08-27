Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6D8492C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 17:34:19 +1000 (EST)
Message-ID: <1377588849.3819.114.camel@pasglop>
Subject: Re: [PATCH 02/10] KVM: PPC: reserve a capability number for
 multitce support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gleb Natapov <gleb@redhat.com>
Date: Tue, 27 Aug 2013 17:34:09 +1000
In-Reply-To: <20130827064026.GB22899@redhat.com>
References: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
 <1375332272-22176-3-git-send-email-aik@ozlabs.ru>
 <1376441474.4255.39.camel@pasglop> <20130826123753.GA22977@redhat.com>
 <1377577198.3819.102.camel@pasglop> <20130827064026.GB22899@redhat.com>
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

On Tue, 2013-08-27 at 09:40 +0300, Gleb Natapov wrote:
> > Thanks. Since it's not in a topic branch that I can pull, I'm going to
> > just cherry-pick them. However, they are in your "queue" branch, not
> > "next" branch. Should I still assume this is a stable branch and that
> > the numbers aren't going to change ?
> > 
> Queue will become next after I will test it and if test will fail the
> commit hash may change, but since you are going to cherry-pick and this
> does not preserve commit hash it does not matter.

Right, as long as the actual cap and ioctl numbers remain stable :-)

Cheers,
Ben.
