Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2DBB567A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 02:50:55 +1100 (EST)
In-Reply-To: <003b01c520c5$6c44edf0$84be1942@Osiris>
References: <003b01c520c5$6c44edf0$84be1942@Osiris>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <877fe95be7fdf95d495d7685a218bd4a@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 4 Mar 2005 09:50:46 -0600
To: "Matt Berry" <mgberry@ellipticity.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Tool Chain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You can use crosstool (kegel.com/crosstool) and build the standard=20
linux ppc toolchain.  The core in the 5200 is a standard 603.

- kumar

On Mar 4, 2005, at 8:13 AM, Matt Berry wrote:

> I am trying to get the 2.6 running on my lite5200 eval board.=A0 Is=20
> there a tool chain allready availble or will I need to build my own?
> =A0
> Thanks,
> =A0
> Matt
> <ATT258655.txt>=
