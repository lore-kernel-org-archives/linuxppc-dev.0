Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5321CB70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Nov 2009 12:58:09 +1100 (EST)
In-Reply-To: <1259357673.2076.6.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<8E6E11A2-25F1-4AB8-B42E-58C269018CD2@kernel.crashing.org>
	<4B0D65C5.8090304@yahoo.es>
	<7556BF73-5D6D-4817-A02F-3DFA05E9AC58@kernel.crashing.org>
	<4B0EFBB2.9090206@yahoo.es>
	<9741644C-BED3-45D9-B405-4C4FC2184DC7@kernel.crashing.org>
	<786BBFA3-39AF-4100-8406-6B32258D3174@kernel.crashing.org>
	<4B100BF4.5080209@yahoo.es> <1259! 357673.2076.6.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <99B59D17-B6C7-42F7-9DF2-E803578651E9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
Date: Sat, 28 Nov 2009 03:04:50 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> It turns out that we _need_ to ack the RSW (Reset Switch) interrupt.
>> The other interrupt sources checked (EXI, VI, DI, AI, DSP/ARAM) need
>> no explicit ack.
>
> That would probably mean that the reset switch interrupt is an edge
> interrupt.

Nah, it means that the RSW is a flip-flop.


Segher
