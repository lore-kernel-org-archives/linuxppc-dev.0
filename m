Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 19CA1DDDE6
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 01:04:39 +1000 (EST)
Date: Mon, 21 Jul 2008 11:04:39 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Don't panic when EEH_MAX_FAILS is exceeded
Message-ID: <20080721110439.50b5a2dc@lappy.seanm.ca>
In-Reply-To: <20080721140946.ca314d2e.sfr@canb.auug.org.au>
References: <488383D4.9000602@us.ibm.com>
	<20080720145858.5be92934@lappy.seanm.ca>
	<20080720201708.GP9594@localdomain>
	<20080720234756.03b602ca@lappy.seanm.ca>
	<20080721140946.ca314d2e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	Sean MacLennan <sean.maclennan@ottawa.kanatek.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Jul 2008 14:09:46 +1000
"Stephen Rothwell" <sfr@canb.auug.org.au> wrote:

> I think you must be thinking of mdelay().

Correct you are! I didn't even know there was an msleep() so I just
mapped it to mdelay() ;)

I'll have to look at msleep() though, there are places we could use it.

Cheers,
   Sean
