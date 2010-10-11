Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88032B70D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 10:12:59 +1100 (EST)
Message-ID: <4CB393EB.3060405@zytor.com>
Date: Mon, 11 Oct 2010 15:47:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH] allow low HZ values?
References: <20101011201121.GA953@tpepper-t61p.dolavim.us>
	<1286836212.5220.19.camel@pasglop>
	<alpine.LFD.2.00.1010120032060.2909@localhost6.localdomain6>
In-Reply-To: <alpine.LFD.2.00.1010120032060.2909@localhost6.localdomain6>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marcio Saito <marcio@cyclades.com>, Jiri Slaby <jirislaby@gmail.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Tim Pepper <lnxninja@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, John Stultz <johnstul@us.ibm.com>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/11/2010 03:33 PM, Thomas Gleixner wrote:
> On Tue, 12 Oct 2010, Benjamin Herrenschmidt wrote:
> 
>> On Mon, 2010-10-11 at 13:11 -0700, Tim Pepper wrote:
>>> I'm not necessarily wanting to open up the age old question of "what is
>>> a good HZ", but we were doing some testing on timer tick overheads for
>>> HPC applications and this came up...
>>
>> Note that this is also very useful when working on CPU prototypes
>> implemented in FPGAs and running at something like 12Mhz :-)
> 
> /me hands benh 0.5$ for a FPGA upgrade

That's often not possible if the CPU cannot be mapped onto a single FPGA
(either because the core is too large, multiple cores are tested, or
because there is debugging logic is included.)  The interconnects slows
things down tremendously.

	-hpa
