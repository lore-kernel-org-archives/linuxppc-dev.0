Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 14EB8B7B66
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 11:56:40 +1100 (EST)
Date: Mon, 7 Dec 2009 19:56:37 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: BUG: Bad page map in process
Message-ID: <20091207195637.7e533845@lappy.seanm.ca>
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

I have not been able to reproduce the problem :( I haven't had a lot of
time to run tests... but every once in a while I have been firing off
test runs.

Maybe writing this email will get it to crash ;)

Cheers,
   Sean
