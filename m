Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8936FDDE45
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 18:41:13 +1000 (EST)
In-Reply-To: <1180945726.10048.0.camel@localhost.localdomain>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
	<1180492466.12577.6.camel@localhost.localdomain>
	<A78C881D-26C3-4545-85CA-80C05085C039@kernel.crashing.org>
	<1180503967.12577.20.camel@localhost.localdomain>
	<19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
	<976AFF56-7590-46B9-ADCA-4FA6673D4C9B@kernel.crashing.org>
	<1180945726.10048.0.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dc4e7ef8f03da79b9322f21b8b82c6d9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
Date: Mon, 4 Jun 2007 10:41:07 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> After some discussion on IRC I think the following is the suggested
>> node we should add in.
>>
>> guts@e00000 {
>>         compatible = "fsl,mpc8548-guts";
>>         reg = <e00000 1000>;
> one more zero!

Yeah.

>>         fsl,has-rstcr;
>> };

If "guts" is some kind of official name (i.e., the
block is called that in the user manual), it looks
okay to me.  Otherwise, please change; in fact, just
change the name anyway (not the compatible), to
"shared-soc-regs" or something like that; "name"
should be descriptive (but terse).


Segher
