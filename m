Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60D3FDDFEA
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 10:12:36 +1000 (EST)
In-Reply-To: <48890D8A.5040001@mindspring.com>
References: <48890B3B.8060806@us.ibm.com> <48890D8A.5040001@mindspring.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <95cc71deeb96188f3730f98608a52d19@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: link failure: file truncated
Date: Fri, 25 Jul 2008 01:51:27 +0200
To: Chuck Meade <chuckmeade@mindspring.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Just tried to build the latest version from Linus' tree and I am 
>> getting
>> a link error.

I can reproduce this now, with 3.4.6 + 2.15, on powerpc64 defconfig
(with the drivers that don't compile with 3.4.6 disabled).

I have a fix for the warning with 2.17, but that's just a warning,
so I'll wait sending it until we know what causes the error.

Stay tuned :-)


Segher
