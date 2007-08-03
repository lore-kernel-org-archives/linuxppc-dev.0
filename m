Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7ECBDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 19:26:59 +1000 (EST)
In-Reply-To: <18098.62189.596336.471217@cargo.ozlabs.ibm.com>
References: <11860870353423-git-send-email-becky.bruce@freescale.com>
	<18098.62189.596336.471217@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <03710186-3483-463E-AF3E-4FB7EAC2470E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix FSL BookE machine check reporting
Date: Fri, 3 Aug 2007 04:28:07 -0500
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


On Aug 3, 2007, at 4:18 AM, Paul Mackerras wrote:

> Becky Bruce writes:
>
>> Reserved MCSR bits on FSL BookE parts may have spurious values
>> when mcheck occurs.  Mask these off when printing the MCSR to
>> avoid confusion.  Also, get rid of the MCSR_GL_CI bit defined
>> for e500 - this bit doesn't actually have any meaning.
>
> Is this needed for 2.6.23?

It would be nice.  I'll queue it up with some other fixes for 2.6.23.

- k
