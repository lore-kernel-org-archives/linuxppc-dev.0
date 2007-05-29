Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A6E7DDE40
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:20:41 +1000 (EST)
In-Reply-To: <1180429370.19517.142.camel@localhost.localdomain>
References: <20070529064531.D874CDDF70@ozlabs.org>
	<1180429370.19517.142.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C31B9167-94B6-48B4-9529-78702E962460@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/5] powerpc: Cleanup ptrace bits
Date: Tue, 29 May 2007 08:19:42 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ulrich.weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 4:02 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2007-05-29 at 16:45 +1000, Benjamin Herrenschmidt wrote:
>>
>> This patch cleans that up a bit by having a ptrace-common.h which
>> contains
>> really common code (and makes a lot more code common), and
>> ptrace-ppc32.h and
>> ptrace-ppc64.h files that contain the few remaining different bits.
>
> Hrm.. we do have a subtle difference in vrregs that I've missed.. I'll
> respin tomorrow. It looks like we don't store the VRSAVE register  
> at the
> same place on 32 and 64 bits... yuck. I need to double check tomorrow.

That's bad.  We really should have VRSAVE in the same location for  
both.  (wondering if GDB expects it a different locations on 32 vs 64- 
bits.)

- k
