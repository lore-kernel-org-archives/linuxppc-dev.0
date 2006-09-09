Return-Path: <jcrigby@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 9D93967BA4
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Sep 2006 14:31:23 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id i2so806611nfe
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Sep 2006 21:31:21 -0700 (PDT)
Message-ID: <4b73d43f0609082131u7331588fs3f7e31b6fb4e722c@mail.gmail.com>
Date: Fri, 8 Sep 2006 22:31:20 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: powerpc power management
In-Reply-To: <17666.7265.178581.550386@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4b73d43f0609071905j26ab0317k144d78963e041cba@mail.gmail.com>
	<450121E2.5050207@in.ibm.com>
	<4b73d43f0609080718g743b9e6bje7202e5293c0abaa@mail.gmail.com>
	<17666.7265.178581.550386@cargo.ozlabs.ibm.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Generally the issue is not with getting the processor into sleep mode,
> it's how you poke the rest of the system to put the RAM into
> self-refresh mode, power down external buses, etc.  That stuff tends
> to be very platform-specific.
Yes you are right, I was asking about the cpu core not all the
external devices.  I realize that the majority of the code is in the
rest of the system.
