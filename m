Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B6A3DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 08:56:18 +1100 (EST)
Message-Id: <975B5B2B-C1F3-4021-9AE2-8873FFE1BDEC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: balbir@linux.vnet.ibm.com
In-Reply-To: <4759BCA2.1020809@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
Date: Fri, 7 Dec 2007 15:55:20 -0600
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207212817.GA391@lixom.net>
	<4759BCA2.1020809@linux.vnet.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2007, at 3:35 PM, Balbir Singh wrote:

> Olof Johansson wrote:
>> Hi,
>>
>> On Sat, Dec 08, 2007 at 02:44:25AM +0530, Balbir Singh wrote:
>>
>>> Comments are as always welcome!
>>
>> Care to explain what this is useful for? (Not saying it's a stupid  
>> idea,
>> just wondering what the reason for doing it is).
>>
>
> In my case, I use it to test parts of my memory controller patches  
> on an
> emulated NUMA machine. I plan to use it to test out page migration
> across nodes.

Can you explain that further.  I'm still not clear on why this is  
useful.

- k
