Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A46E2DDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 22:52:49 +1000 (EST)
In-Reply-To: <18002.50866.169757.638254@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0705170756500.4833@localhost.localdomain>
	<18002.50866.169757.638254@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <38BEB8AA-A970-478C-8546-B0AA692C7051@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PPC] Remove duplicate export of __div64_32.
Date: Tue, 22 May 2007 07:51:02 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 22, 2007, at 5:32 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> We now get the export of __div64_32 from lib/div64.c and can drop  
>> the one
>> in ppc_ksysm.c
>
> Great, but please remove the #include <asm/div64.h> as well.

git-amend'd :)

- k
