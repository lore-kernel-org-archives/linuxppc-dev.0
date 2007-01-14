Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8E8CDDE9E
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 10:43:13 +1100 (EST)
In-Reply-To: <37cdcd37b9252ee18fa458b22e8bdd60@kernel.crashing.org>
References: <20070114225502.GA21471@austin.ibm.com>
	<17834.47158.581922.62728@cargo.ozlabs.ibm.com>
	<37cdcd37b9252ee18fa458b22e8bdd60@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8efd33607840e2099e327c573b4a9a07@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] atomic_dec_if_positive sign extension fix
Date: Mon, 15 Jan 2007 00:43:43 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> What is this function supposed to do if it gets 0x80000000 as
> input btw?  The current code happily makes it 0x7fffffff as
> far as I can see?  The "rlwinm" thing would fix that ;-)  (Or
> unfix, if the current behaviour is intended).

...except it doesn't change behaviour on 32-bit of
course.  Forget it, do one of the other suggested
things instead please :-)


Segher
