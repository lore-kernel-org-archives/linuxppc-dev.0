Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3241BDE01A
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:51:10 +1000 (EST)
In-Reply-To: <18190.42074.495464.74585@cargo.ozlabs.ibm.com>
References: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
	<3A203D25-2CC1-4450-ADA1-752A99504108@kernel.crashing.org>
	<18190.42074.495464.74585@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4D0E51C1-6B26-4166-AB89-DF9748A6BA97@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: powerpc commits for 2.6.24
Date: Thu, 11 Oct 2007 17:51:33 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 11, 2007, at 5:31 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> I'm debugging one issue with MPC8560 that should get fixed today with
>> a new pull request after I find the issue.
>
> There's no particular hurry for bug fixes.

Already dealt with, mainly I was being stupid.

>> Just to clarify, are we closing 2.6.24 for new code after you send
>> Linus a pull request or are we still taking things during the two
>> week merge window?
>
> Basically, yes.  We got a lecture at kernel summit from Linus and
> Andrew where we got told to get everything merged early in the merge
> window.  I might make an exception for stuff that has already been
> posted for review but still needs some minor changes, but other than
> that, the window for new code has closed.

I was wondering about this case.  I'll follow your lead here.

- k
