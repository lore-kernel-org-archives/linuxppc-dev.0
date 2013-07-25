Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 268AC2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 18:37:51 +1000 (EST)
Message-ID: <51F0E3A0.1080404@asianux.com>
Date: Thu, 25 Jul 2013 16:36:48 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: kernel: remove useless code which related
 with 'max_cpus'
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com> <51ECD0BF.8080605@asianux.com>
 <51ECD3D4.9020405@asianux.com> <51ECD664.7040708@linux.vnet.ibm.com>
 <20130723134431.GF31944@concordia> <51EF1F97.3070409@asianux.com>
 <20130724011640.GA6042@concordia> <51EF375D.9060006@asianux.com>
 <20130725031501.GA15673@concordia> <1374729381.6142.59.camel@pasglop>
 <51F0B68F.4000402@asianux.com> <1374731505.6142.64.camel@pasglop>
 <51F0C2E8.3050005@asianux.com> <1374737592.6142.67.camel@pasglop>
 <51F0DAF1.9060702@asianux.com> <1374739597.6142.68.camel@pasglop>
 <51F0E037.1080609@asianux.com> <1374740911.6142.70.camel@pasglop>
In-Reply-To: <1374740911.6142.70.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: chenhui.zhao@freescale.com, "paulus@samba.org" <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 04:28 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-25 at 16:22 +0800, Chen Gang wrote:
>> > On 07/25/2013 04:06 PM, Benjamin Herrenschmidt wrote:
>>> > > On Thu, 2013-07-25 at 15:59 +0800, Chen Gang wrote:
>>>> > >>
>>>> > >> For my opinion: one fix may like below (assume have removed max_cpus)
>>>> > >> which is more reasonable for code readers.
>>> > > 
>>> > > So instead of just failing to bring the secondary CPUs, but potentially
>>> > > still having a working system, you crash during boot.... potentially
>>> > > before a console is even visible. And this is good how ?
>>> > > 
>> > 
>> > Hmm... how about the above DBG("...") within this function ?
>> > 
>> > One implementation of BUG_ON() is use printk() and coredump, if it is a
>> > critical failure, I suggest to use it (if console is really invisible, I
>> > guess still can generate the coredump).
> Whatever ... looks like you don't feel like listening so I'm not going
> to waste my breath anymore, nor will I accept your patches.

I can understand,

But 'patch' or 'patches' ?  ;-)


Thanks.
-- 
Chen Gang
