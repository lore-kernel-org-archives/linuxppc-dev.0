Return-Path: <Hiroshi_DOYU@montavista.co.jp>
Received: from yuubin.montavista.co.jp (sonicwall.montavista.co.jp
	[202.232.97.131])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 753432BF07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 11:26:10 +1000 (EST)
Date: Fri, 22 Oct 2004 10:26:04 +0900
From: Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To: Eugene Surovegin <ebs@ebshome.net>
Message-Id: <20041022102604.0b6e2d5d.Hiroshi_DOYU@montavista.co.jp>
In-Reply-To: <20041022011907.GA22069@gate.ebshome.net>
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022011907.GA22069@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Eugene,

On Thu, 21 Oct 2004 18:19:07 -0700
Eugene Surovegin <ebs@ebshome.net> wrote:

> On Fri, Oct 22, 2004 at 08:57:33AM +0900, Hiroshi DOYU wrote:
> > Hi all,
> > 
> > Now I am strugging with booting vanilla(2.4.2x) on ibm440gx and
> > I could succeed to boot it but, after nfs mounted, it's behavior 
> > seems too slow. I guess, it looks like the system is running 
> > half duplex. I have attached  the boot message below.
> > 
> > If anyone knows some information about such issue, please let me know.
> 
> Is this 440GX ref platform (Ocotea) or your custom hardware?
> If custom, please, try 440GX ref board and report the results.
> 
> Also, what _exact_ version are you using? 2.4.2x isn't very helpful.

Additonal information:

I am using Ocotea(REV3) and tried v2.4.27.

Thanks,
-doyu

> 
> --
> Eugene
> 
> 
