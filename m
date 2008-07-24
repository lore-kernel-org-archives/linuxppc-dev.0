Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87265DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 08:29:42 +1000 (EST)
In-Reply-To: <20080724001857.42fc7e09@lappy.seanm.ca>
References: <20080724001857.42fc7e09@lappy.seanm.ca>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c7d136a69bb02682bf5f3dbbd658d975@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: section .dummy lma 0xc0294310 overlaps previous sections
Date: Fri, 25 Jul 2008 00:29:28 +0200
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Anybody else seeing these? With Linus' latest I get three of these
> warnings: .tmp_vmlinux1, .tmp_vmlinux2, and vmlinux.

Ah, that's useful information, I think I know what's going on
now.  What was your binutils version?


Segher
