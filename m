Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BB86B7CE4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 04:32:51 +1100 (EST)
In-Reply-To: <4B934CCA.8030608@freemail.hu>
References: <4B934CCA.8030608@freemail.hu>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: cross-compiling Linux for PowerPC e200 core?
Date: Mon, 8 Mar 2010 18:47:29 +0100
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Assembler messages:
> Error: invalid switch -me200
> Error: unrecognized option -me200

No version of mainline binutils supports this.

This kernel code was added in 2005, in 33d9e9b, by FSL; perhaps
they have a fork of binutils that supports it, maybe they forgot
to submit the changes upstream?


Segher
