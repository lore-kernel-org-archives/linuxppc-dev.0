Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1329667B9B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 00:07:14 +1100 (EST)
Message-ID: <45741DDE.4080509@ru.mvista.com>
Date: Mon, 04 Dec 2006 16:08:46 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
In-Reply-To: <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Segher Boessenkool wrote:
>>> Please make this run on pSeries only; on a PowerMac for
>>> example, it's totally normal that the first PCI legacy I/O
>>> BAR in the system gets assigned 0.

>>    What do you mean by legacy I/O BAR?

> Any PCI BAR with bits 1:0 == 0b01.

>> If you mean IDE controller, that would drive IDE core mad like this:
>>
>> W82C105_IDE: inconsistent baseregs (BIOS) for port 0, skipping

> So that needs fixing too, then.

    I'd agree here, that check in the IDE code seems like being too x86 
specific. I'm having issues with it as well on MPC85xx/U-Boot...

> Segher

WBR, Sergei
