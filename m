Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 44AA767C52
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:43:13 +1100 (EST)
Message-ID: <4560C23D.6080304@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:44:45 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>		<1163966437.5826.99.camel@localhost.localdomain>		<20061119200650.GA22949@elte.hu>		<1163967590.5826.104.camel@localhost.localdomain>		<4560BDF5.400@ru.mvista.com>	<1163968376.5826.110.camel@localhost.localdomain>
	<4560C121.30403@ru.mvista.com>
In-Reply-To: <4560C121.30403@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Sergei Shtylyov wrote:

>>On MPIC or XICS, this is implicit by reading the vector. On some more
>>dumb controllers, this has to be done explicitely.

>     This is not implicit -- CPU has to read INTACK reg. on OpenPIC. Really 

    Sorry, it's the same for x86 version of OpenPIC according to spec. I meant 
the PPC implementation here.

>>Ben.

WBR, Sergei
