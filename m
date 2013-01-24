Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42E802C008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 08:45:06 +1100 (EST)
Message-ID: <1359063889.29726.36.camel@pasglop>
Subject: Re: [PATCH powerpc ] Avoid debug_smp_processor_id() check in
 arch_spin_unlock_wait()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Fri, 25 Jan 2013 08:44:49 +1100
In-Reply-To: <1359022384.2666.46.camel@ThinkPad-T5421.cn.ibm.com>
References: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
 <1357797726.4838.89.camel@pasglop>
 <1357808418.10378.16.camel@ThinkPad-T5421.cn.ibm.com>
 <1358999231.29726.9.camel@pasglop>
 <1359022384.2666.46.camel@ThinkPad-T5421.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-24 at 18:13 +0800, Li Zhong wrote:
> I'm not very clear about the "risk" you mentioned above. It seems to me
> that the freeing of lppaca only appeared in free_unused_pacas(), called
> by early setup code, at which time hotplug seems impossible. 
> 
> I must missed something ...

No you are right, we don't free them at the moment.

> I'll update the SHARED_PROCESSOR directly, it seems better to me now.
> (wonder why I gave it up immediately when it first came into my mind
> while I was doing the last update...)

Cheers,
Ben.
