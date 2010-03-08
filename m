Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A001B7D03
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 07:41:51 +1100 (EST)
Message-ID: <53452.84.105.60.153.1268080871.squirrel@gate.crashing.org>
In-Reply-To: <4B9546CD.1000008@freemail.hu>
References: <4B934CCA.8030608@freemail.hu>
	<9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org>
	<4B9546CD.1000008@freemail.hu>
Date: Mon, 8 Mar 2010 21:41:11 +0100 (CET)
Subject: Re: cross-compiling Linux for PowerPC e200 core?
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Assembler messages:
>>> Error: invalid switch -me200
>>> Error: unrecognized option -me200
>>
>> No version of mainline binutils supports this.
>>
>> This kernel code was added in 2005, in 33d9e9b, by FSL; perhaps
>> they have a fork of binutils that supports it, maybe they forgot
>> to submit the changes upstream?
>
> I'm a bit new on the topic, could you please describe what FSL means?

Freescale

> I'm also having problems finding the commit 33d9e9b in the git repository
> at http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git .

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=33d9e9b

There is no obvious way to get there via clicking afaics, the "commit"
search box doesn't work at least.  Hrm.


Segher
