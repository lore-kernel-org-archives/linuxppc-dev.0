Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1737767AA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Jun 2005 19:24:06 +1000 (EST)
Date: Tue, 21 Jun 2005 02:24:03 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: vinod b <bvinodsmail@gmail.com>
Message-ID: <20050621092403.GA15191@gate.ebshome.net>
References: <198df04d050621011328999642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <198df04d050621011328999642@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: booting linux on powerpc 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2005 at 01:43:23PM +0530, vinod b wrote:
> I am sending the output on the minicom window can some 
> body tell me what is the problem.It <http://problem.It> will be of great
>  help.

[snip] 

> Linux version 2.4.18_mvl30-405ep_eval (root@AUM-SAI) (gcc version
> 3.2.1 20020930 (MontaVista)) #1 Sun Jun 19 13:50:01 IST 25
> IBM Walnut (IBM405GP) Platform

So, is it Walnut or 405EP eval?????

> PLB0: bear= 0x10000000 acr=   0x00000000 besr=  0x00000000
> PLB0 to OPB: bear= 0x119a3470 besr0= 0x00000000 besr1= 0x00000000
> 
> GPR00: C00A081C C1FEF590 C1FEE000 00000000 00000005 0000001F 00000000 C1FCD260
> GPR08: 00000002 C1FD3158 C1FCD2D8 C1FD302C 00784263 00000000 00000003 00000000
> GPR16: 00000000 FFFE21AD 00000000 C1FCD460 00000002 C1FCD480 00000000 00000000
> GPR24: C00E00A4 C1FEF6E8 C3004800 00000000 00000000 C1FD3000 00000000 0000009A
> Call backtrace:
> C0000000 C00A081C C00B894C C00B1410 C00B5EB0 C00C45D0 C00C32E0
> C00C3D8C C00E0404 C00E7724 C00A96FC C00F4518 C00F373C C00F36C4
> C00F1794 C00F5AA4 C00F5D5C C00F0EF4 C006B944 C00657DC C0042744
> C0042C6C C0042FE8 C0040060 C0055D98 C00409EC C0040C14 C0005644
> C00028FC C0002708 C0004E6C

These numbers are useless for anybody here, please decode this oops 
(using ppc_405-ksymoops) if you expect any help.

-- 
Eugene
