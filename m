Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 153FB679F0
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Dec 2006 03:42:40 +1100 (EST)
Message-ID: <457AE7D6.4060503@ru.mvista.com>
Date: Sat, 09 Dec 2006 19:44:06 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] powerpc: experimental of serial port driver
References: <200612072140.47405.arnd@arndb.de>	<200612081612.28385.arnd@arndb.de>	<1165611049.1103.37.camel@localhost.localdomain>	<200612090042.58601.arnd@arndb.de>
	<1165630432.1103.107.camel@localhost.localdomain>
In-Reply-To: <1165630432.1103.107.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>>We sill need to fixup legacy_serial to detect them on opb right ?

>>Yes, I have another patch for that. Currently, the port registers
>>as compatible="ns16750", which is different from all the others
>>in legacy_serial. Do you think it should be 
>>compatible="nc16750\0ns16550" instead, so we can use the same
>>as the others? It actually _is_ compatible to 16550 anyway.

> Both strings then.

    Then it should be something like "nc16750\0ns16550\0ns16450\08250".

> Ben.

WBR, Sergei
