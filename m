Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5626067BBB
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 06:43:38 +1000 (EST)
Message-ID: <45144AFB.7030309@ru.mvista.com>
Date: Sat, 23 Sep 2006 00:43:39 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
References: <A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
	<20060920215738.GC24809@mag.az.mvista.com>
	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
	<20060921133707.GA29137@gate.crashing.org>
	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
	<20060922012408.GA13820@mag.az.mvista.com>
	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>
	<20060922185923.GB25738@mag.az.mvista.com>
	<45143B2B.7060501@ru.mvista.com>
	<20060922204013.GA29524@mag.az.mvista.com>
In-Reply-To: <20060922204013.GA29524@mag.az.mvista.com>
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

Mark A. Greer wrote:

>>>3) The number of cells in the "size" portion of the tuple is indicated
>>>by the nearest #size-cells as you go up the tree.  Just like the "reg"
>>>property.

>>   Well, is there need for duplication of size if "reg" prop must be 
>>   present anyway?

> We're not adding another #size-cells, we're using the same one that
> "reg" uses.  No duplication, just reuse.

    I mean size could have been gotten from "reg" prop.

> Mark

WBR, Sergei
