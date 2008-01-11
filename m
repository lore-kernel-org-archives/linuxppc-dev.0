Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id 8845CDE01B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jan 2008 19:50:18 +1100 (EST)
In-Reply-To: <47865A80.7050205@freescale.com>
Subject: Re: 2.6.22-ppc8xx fec.c bugs
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF431AD1B5.8B0529FD-ONC12573CD.002EB1C5-C12573CD.0030B37E@abengoa.com>
Date: Fri, 11 Jan 2008 09:51:30 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
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







>>raul.moreno@telvent.abengoa.com wrote:
>> Hello everyone,
>>
>> I don't know who the maintainer of the FEC (Fast Ethernet Controller=
) in
>> the ppc8xx achitecture is, so I am writing this email here.

>arch/ppc is deprecated, and arch/ppc/8xx_io especially so.

>Please use drivers/net/fs_enet (and also note that arch/ppc will be
>going away in a few months).

I didn't know ppc was deprecated. Why is it so? Could you tell me where=
 can
I read anything about this issue?
I have been using this architecture since I started with Linux (not too=

long ago) because I manage a mpc866 processor.
Do you mean that I should port to arch/powerpc?

>> I've seen that some bugs were fixed in the latest kernel but others
haven't
>> been addressed (possibly undetected yet). The following is a diff wi=
th
>> corrections I made to the 2.6.22 'fec.c' file (currently seems to wo=
rk
>> fine).

>Please post patches against the latest head-of-tree, and in unified di=
ff
>format (diff -u).

I'll do it in this way for next patches.

Ra=FAl
=
