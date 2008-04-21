Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1B5B5DEDDC
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 02:21:25 +1000 (EST)
Message-ID: <480CBEE0.9000104@ru.mvista.com>
Date: Mon, 21 Apr 2008 20:20:48 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Subject: Re: pci issue - wrong detection of pci ressources
References: <48088F02.2060806@linux.vnet.ibm.com>	<1208566122.6958.425.camel@pasglop>	<480BA937.7050603@linux.vnet.ibm.com>	<1208727408.7009.0.camel@pasglop>	<480C80B6.30904@linux.vnet.ibm.com>	<480C87BD.8090207@ru.mvista.com>	<480C9FE2.4030601@linux.vnet.ibm.com>
	<480CAFD2.2050108@ru.mvista.com>
In-Reply-To: <480CAFD2.2050108@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>    Ah, that's what happens -- BAR0 in functions 0/1 takes up the whole 
> 265 MiB of the PCI memory space (128+128), so no place is left for other 
> memory BARs.

    What's interesting, the Sequoia/Rainier board user manual says that PCI 
memory is 0x80000000 thru 0xbfffffff (i.e. 1 GiB), while the Linux code seem 
to always have assumed only 0x[1]800000000 thru 0x[1]8fffffff...

WBR, Sergei
