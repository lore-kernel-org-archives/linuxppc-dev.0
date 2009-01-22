Return-Path: <daniel.ng1234@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id C1317DDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 18:47:03 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1651051ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 23:47:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090121175225.GB31266@ld0162-tx32.am.freescale.net>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
	<20090116181405.GB722@ld0162-tx32.am.freescale.net>
	<547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
	<547eba1b0901192323i2a505dcg841d42092dc5dd5d@mail.gmail.com>
	<20090120164124.GC8978@ld0162-tx32.am.freescale.net>
	<547eba1b0901202337g624f79b2uaa7f7f2f61990ad1@mail.gmail.com>
	<20090121175225.GB31266@ld0162-tx32.am.freescale.net>
Date: Thu, 22 Jan 2009 18:47:01 +1100
Message-ID: <547eba1b0901212347v47c9ee4at40e2188c50351952@mail.gmail.com>
Subject: Re: Device Tree setup for 8272-based board
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2009 at 4:52 AM, Scott Wood <scottwood@freescale.com> wrote:
>> 3) In the PIC: interrupt-controller@10c00 node-
>> reg = <0x10c00 0x80>;
>
> Offset and length of PIC registers.

Thanks Scott. What is the meaning of the Ethernet reg field?:

reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;

Is it-

0x11300-> GFMR1 ie. the GFMR for FCC1?
0x20-> GFMR1 Fields are a total of 32 bits?
0x8400-> initial value of bits 0-15 of GFMR1?
0x100-> initial value of bits 16-31 of GFMR1?
0x11390-> GFEMR1?
0x1-> length of GFEMR1 is 1 bit in size?? (this doesn't make sense
because it's a 3-bit field)
Where would we specify the initial value of GFEMR1?

Cheers,
Daniel
