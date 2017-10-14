Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDRgl29lWzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 12:24:03 +1100 (AEDT)
Date: Sat, 14 Oct 2017 12:23:58 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
Message-ID: <20171014012358.GC26120@fergus.ozlabs.ibm.com>
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
 <20171013011651.35b2de97@bahia.lab.toulouse-stg.fr.ibm.com>
 <25aebd00-6cb3-3506-55d1-41b3bbe6ab1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25aebd00-6cb3-3506-55d1-41b3bbe6ab1b@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 13, 2017 at 06:14:00PM +0200, Paolo Bonzini wrote:
> On 13/10/2017 01:16, Greg Kurz wrote:
> > Ping ?
> 
> When is Paul back from vacation? :)

Now. :)

Paul.
