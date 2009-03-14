Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEC6FDE0D2
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 00:48:21 +1100 (EST)
In-Reply-To: <1236984351.25062.71.camel@pasglop>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FFBC9638-D064-43F9-B764-243739289710@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs,
	and VSRs in the MSR
Date: Sat, 14 Mar 2009 14:49:02 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Another option might be simply to say that if an app has used FP,  
> VMX or
> VSX -once-, then it's likely to do it again and just keep re-enabling
> it :-)
>
> I'm serious here, do we know that many cases where these things are  
> used
> seldomly once in a while ?

For FP, I believe many apps use it only sporadically.  But for VMX  
and VSX,
yeah, it might well be optimal to keep it enabled all the time.  Someone
should do some profiling...


Segher
