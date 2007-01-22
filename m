Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 166FDDDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Jan 2007 14:12:38 +1100 (EST)
In-Reply-To: <000001c73c40$0cbaf120$6405a8c0@absolut>
To: "Russell McGuire" <rmcguire@uwbt.com>
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
MIME-Version: 1.0
Message-ID: <OF26054860.9E484967-ON8825726B.00111F6F-8825726B.00119DA9@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Sun, 21 Jan 2007 19:12:33 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Russell McGuire" <rmcguire@uwbt.com> wrote on 01/19/2007 07:06:56 PM:

> Bruce,
> 
> Did you ever get linux to boot up?
> 
> I am wondering if I am having similar problems on my system, though it 
is
> based on the MPC8360E. Serial port code and clocking is the same between
> these systems, at least it should be.
> 
> 
Russ (and anyone else who may be watching this thread),

I did finally get the 2.6.19 kernel to boot using u-boot 1.2.0/open 
firmware device tree, but I had to do some hacking on a *.dts file that 
Timur sent me.  There may also be issues with assumptions that u-boot 
makes versus the assumptions the kernel makes versus assumptions that DTC 
make.  But, I haven't had a chance to work this issue for the last few 
days and before I put out a final word I want to have all my ducks in a 
row.  I'm going to get back to this on Monday, so stand by for more 
tomorrow evening.

Bruce
