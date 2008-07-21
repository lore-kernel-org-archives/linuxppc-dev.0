Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id B6AF4DDECF
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:47:55 +1000 (EST)
Date: Sun, 20 Jul 2008 23:47:56 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Nathan Lynch" <ntl@pobox.com>
Subject: Re: [PATCH] Don't panic when EEH_MAX_FAILS is exceeded
Message-ID: <20080720234756.03b602ca@lappy.seanm.ca>
In-Reply-To: <20080720201708.GP9594@localdomain>
References: <488383D4.9000602@us.ibm.com>
	<20080720145858.5be92934@lappy.seanm.ca>
	<20080720201708.GP9594@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <sean.maclennan@ottawa.kanatek.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 20 Jul 2008 15:17:08 -0500
"Nathan Lynch" <ntl@pobox.com> wrote:

> Sean MacLennan wrote:
>
> > Why can you not msleep within a spinlock? And when was this change
> > brought in?
> 
> Giving up the cpu while holding a spinlock risks locking up the system
> in the worst case -- if another task tries to acquire the held lock it
> can spin indefinitely.

I guess I am too x86 centric. On the x86 an msleep does not give up the
CPU. It does a busy wait.

So what sleep do you use on the PowerPC when you need a delay for
hardware reasons?

Cheers,
   Sean
