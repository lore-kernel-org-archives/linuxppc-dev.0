Return-Path: <pochini@shiny.it>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 024DE67A62
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 22:52:24 +1000 (EST)
Message-ID: <XFMail.20060525144619.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20060523225113.GD11414@localdomain>
Date: Thu, 25 May 2006 14:46:19 +0200 (CEST)
Sender: pochini@agnus.shiny.it
From: Giuliano Pochini <pochini@shiny.it>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: CPU 1 refused to die!
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 23-May-2006 Nathan Lynch wrote:
> Giuliano Pochini wrote:
>>
>> I booted with maxcpus=1, then I enabled the 2nd cpu
>> with echo 1 > /sys/devices/system/cpu/cpu1/online
>
> So onlining at runtime seems to work.  Did you verify that tasks get
> run on the 2nd cpu after you online it?

Yes, I did, and the difference in speed is pretty obvious.


> Any other strange messages in dmesg?

Nothing unusual.


> Can you online and offline cpus if you boot without maxcpus=1?

It behaves exactly the same. I can't say exactly when it stopped
working. 2.6.14 worked fine.


--
Giuliano.
