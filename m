Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CE1BC67BAA
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Sep 2006 01:48:09 +1000 (EST)
Message-ID: <45155738.9030404@ru.mvista.com>
Date: Sat, 23 Sep 2006 19:48:08 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
References: <20060920012042.GA28489@mag.az.mvista.com>	<1158721828.3043.13.camel@vader.jdub.homelinux.org>	<A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>	<1158787957.6002.307.camel@localhost.localdomain>	<20060920215738.GC24809@mag.az.mvista.com>	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>	<20060921133707.GA29137@gate.crashing.org>	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>	<20060922012408.GA13820@mag.az.mvista.com>	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>
	<20060922185923.GB25738@mag.az.mvista.com>
	<45143B2B.7060501@ru.mvista.com>
	<91D1965E-2377-4ADB-B6F9-2B5A1549D75B@kernel.crashing.org>
In-Reply-To: <91D1965E-2377-4ADB-B6F9-2B5A1549D75B@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Matt Porter <mporter@embeddedalley.com>, Paul Mackerras <paulus@samba.org>,
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
>>    Well, is there need for duplication of size if "reg" prop must  be 
>> present anyway?

> No, not really.  But this way, "reg" can be absent, actually.

    Is this a joke? :-)
    Or you're supposing that UART is only usable to the bootwrapper? Or you're 
going to add support for this new prop to the main kernel as well?

> Segher

WBR, Sergei
