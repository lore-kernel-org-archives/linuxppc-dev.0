Return-Path: <richard.danter@ntlworld.com>
Received: from mta07-winn.ispmail.ntl.com (mta07-winn.ispmail.ntl.com
	[81.103.221.47]) by ozlabs.org (Postfix) with ESMTP id 76501687A5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Nov 2005 06:44:04 +1100 (EST)
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
	by mta07-winn.ispmail.ntl.com with ESMTP id
	<20051122194401.TRFA21883.mta07-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Nov 2005 19:44:01 +0000
Received: from [192.168.1.10] (really [82.4.184.52])
	by aamta11-winn.ispmail.ntl.com with ESMTP id
	<20051122194401.NQEC16192.aamta11-winn.ispmail.ntl.com@[192.168.1.10]>
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Nov 2005 19:44:01 +0000
Message-ID: <438374FE.4040608@ntlworld.com>
Date: Tue, 22 Nov 2005 19:43:58 +0000
From: Richard Danter <richard.danter@ntlworld.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <4382F0F2.4040807@ntlworld.com>
In-Reply-To: <4382F0F2.4040807@ntlworld.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Trying to understand initsenses and pci_irq_table
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Richard Danter wrote:
> 
> The kernel crashes after starting init. I see some random characters on 
> the serial and then nothing. Looking in the log buffer via JTAG I can 
> see that the init process exited with signal 11. I assume this is 
> unrelated to the above, but any suggestions where I should look?

I managed to fix this problem, so I am now booted and running busybox 
from NFS :)

I'd still like a pointer to any docs explaining the PCI and interrupt 
stuff if possible.

Thanks!
Rich
