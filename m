Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2FB5FB7BF8
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 03:37:15 +1100 (EST)
Date: Fri, 4 Dec 2009 11:37:13 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: BUG: Bad page map in process
Message-ID: <20091204113713.5b5e64a0@opus.seanm.ca>
In-Reply-To: <1259925535.2076.1275.camel@pasglop>
References: <20091203141853.3eafba47@lappy.seanm.ca>
	<1259917707.2076.1271.camel@pasglop>
	<20091204110055.GP14279@hansolo.jdub.homelinux.org>
	<1259925535.2076.1275.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 04 Dec 2009 22:18:55 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Ok, I'll have a look next week. In the meantime, Sean, can you give
> me a hint of what you do to trigger it ? Boot time ? specific
> workload ?

It hasn't happened that often, but I have been focusing on 2.6.31.

So far, it has always happened well after the boot, but not hours. I
haven't worked out a specific workload.

Cheers,
   Sean
