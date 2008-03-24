Return-Path: <sshtylyov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8AAFEDE180
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 04:02:20 +1100 (EST)
Message-ID: <47E7DEF1.9050501@ru.mvista.com>
Date: Mon, 24 Mar 2008 20:03:45 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
References: <12060242324116-git-send-email-john.linn@xilinx.com>		<20080320144402.3063517C005D@mail148-sin.bigfish.com>		<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>		<18403.32257.725539.470771@cargo.ozlabs.ibm.com>		<fa686aa40803220750h1d86589am9a26aeeb359178b7@mail.gmail.com>		<47E7B61B.70708@ru.mvista.com>	<fa686aa40803240727p14c7e8c0r8575f7d5feb776dd@mail.gmail.com>
	<47E7D3BB.1050403@ru.mvista.com>
In-Reply-To: <47E7D3BB.1050403@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, I wrote:

>    Oh, well... unfortunately, we can't use UPIO_MEM32 "register model" 
> in 8250.c anyway since that makes use of readl()/writel() -- which treat 
> the bus as bigendian on PPC... anyway, we would need at least a 

    I was going to write "as little-endian"... :-<

> "reg-size" property, if not new "compatible"...

WBR, Sergei
