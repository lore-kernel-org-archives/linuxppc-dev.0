Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 153AF2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 15:25:36 +1000 (EST)
Message-ID: <51F0B68F.4000402@asianux.com>
Date: Thu, 25 Jul 2013 13:24:31 +0800
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
In-Reply-To: <1374729381.6142.59.camel@pasglop>
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

On 07/25/2013 01:16 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-25 at 13:15 +1000, Michael Ellerman wrote:
>>> But for API (also include the internal API), at least, better to always
>>> provide the return value which can indicate failure by negative number
>>> (if succeed can return the meanness value, e.g. the number of cpus).
>>
>> Are we still talking about this?
>>
>> There is no point returning a value when no one checks it. Which is the
>> case here.
> 
> Right. The return value is historical, it dates from when we didn't have
> cpu_possible_mask etc...
> 
> Nowadays, the probe() routine is just some early init, and might also
> affect those masks if needed, the return value has become obsolete.
> 
> You are welcome to post a patch removing it.
> 

For an extern function, if the performance is not sensible, better to
have the return value which can indicate the failure with the negative
number.


Thanks.
-- 
Chen Gang
