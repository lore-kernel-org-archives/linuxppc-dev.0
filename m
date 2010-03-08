Return-Path: <nm127@freemail.hu>
Received: from relay01.digicable.hu (relay01.digicable.hu [92.249.128.189])
	by ozlabs.org (Postfix) with ESMTP id 4231CB7CFD
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 05:49:54 +1100 (EST)
Message-ID: <4B9546CD.1000008@freemail.hu>
Date: Mon, 08 Mar 2010 19:49:49 +0100
From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: cross-compiling Linux for PowerPC e200 core?
References: <4B934CCA.8030608@freemail.hu>
	<9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org>
In-Reply-To: <9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
Segher Boessenkool wrote:
>> Assembler messages:
>> Error: invalid switch -me200
>> Error: unrecognized option -me200
> 
> No version of mainline binutils supports this.
> 
> This kernel code was added in 2005, in 33d9e9b, by FSL; perhaps
> they have a fork of binutils that supports it, maybe they forgot
> to submit the changes upstream?

I'm a bit new on the topic, could you please describe what FSL means?

I'm also having problems finding the commit 33d9e9b in the git repository
at http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git .

Regards,

	Márton Németh
