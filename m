Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 8A1C1DDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 00:34:21 +1000 (EST)
Message-ID: <47161D79.6000003@ru.mvista.com>
Date: Wed, 17 Oct 2007 18:34:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
In-Reply-To: <18195.64334.985238.848522@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

>>    I'd use (evt - 1) since the interrupt gets generated at 0xffffffff count, 
>>not 0 (on classic CPUs).  With you removing of the code that compensated for 

> See commit d968014b7280e2c447b20363e576999040ac72ef; I already fixed
> that.

    BTW, while fixing that for classic PPC, but you've broke it for 40x / book 
E CPU which interrupt at 0.  Congratulations. :-)

WBR, Sergei
