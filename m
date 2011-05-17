Return-Path: <mtosatti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id F199DB6EE8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2011 04:10:44 +1000 (EST)
Date: Tue, 17 May 2011 15:10:38 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 08/13] kvm/powerpc: Move guest enter/exit down into
	subarch-specific code
Message-ID: <20110517181038.GB9728@amt.cnet>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104331.GI2837@brick.ozlabs.ibm.com>
	<20110517180511.GA9728@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110517180511.GA9728@amt.cnet>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 17, 2011 at 03:05:12PM -0300, Marcelo Tosatti wrote:
> >  
> > -	ret = __kvmppc_vcpu_entry(kvm_run, vcpu);
> > +	kvm_guest_enter();
> 
> 
> kvm_guest_enter should run with interrupts disabled.

Its fine, please ignore message.
