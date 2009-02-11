Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 3038BDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 10:55:37 +1100 (EST)
To: "Shubhada Pugaonkar" <shubhada@chelsio.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: AMCC ppc440spe 2.6.23.10 kernel boot help
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <8A71B368A89016469F72CD08050AD33402D57544@maui.asicdesigners.com>
References: <8A71B368A89016469F72CD08050AD33402D57544@maui.asicdesigners.com>
Date: Thu, 12 Feb 2009 00:55:33 +0100
Message-Id: <20090211235533.8B319832E893@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear "Shubhada Pugaonkar",

In message <8A71B368A89016469F72CD08050AD33402D57544@maui.asicdesigners.com> you wrote:
> 
> I am trying to bringup AMCC ppc440sPE  board with 2.6.23.10 kernel from

2.6.23.10 is very old. Please use current code. 2.6.23 was long before
the switch to arch/powerpc, so all the efforts you are spnding now on
this old stuff are really wasted.

Use at least 2.6.28 or later.

> kernel.org. My .config file is attached. I used ARCH=ppc and

Why don't you start with a good, known to work kernel config file
like 44x/katmai_defconfig ?

For example, you mention a 440SPe processor above, but your config
file seems to be derived from a Luan board, which is 440SP (not SPe)
so there is not much surprise if it doesn't work.


> CROSS_COMPILE=ppc-linux- (also tried ppc_4xx-) and did 'make uImage',
> but unable to boot into the kernel. My nfs and uboot settings seem to be
> correct. The kernel gets stuck as shown below. Any help appreciated.
> Please let me know if any more information is required.

In the first place, please use current code.

Second - which exact board is this? Katmai?

> => run flash_nfs

What exactly are your environment settings? Which exact value of
"bootargs" do you pass to Linux? Does it include a valid console=
argument?


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"If you'll excuse me a minute, I'm going to have a cup of coffee."
- broadcast from Apollo 11's LEM, "Eagle", to Johnson  Space  Center,
Houston July 20, 1969, 7:27 P.M.
