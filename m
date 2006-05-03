Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4287767B22
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 03:18:39 +1000 (EST)
Date: Wed, 3 May 2006 10:18:01 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stephen Winiecki <stevewin@us.ibm.com>
Subject: Re: Fw: Configuring PCI w/ 44x
Message-ID: <20060503171801.GB32503@gate.ebshome.net>
References: <OF417BCEEB.CBCC9EBC-ON87257163.005DB572-85257163.005E34EB@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF417BCEEB.CBCC9EBC-ON87257163.005DB572-85257163.005E34EB@us.ibm.com>
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

On Wed, May 03, 2006 at 01:11:26PM -0400, Stephen Winiecki wrote:
> 
> Eugene Surovegin <ebs@ebshome.net> wrote on 05/02/2006 07:49:16 PM:
> 
> > On Tue, May 02, 2006 at 04:58:32PM -0400, Stephen Winiecki wrote:
> > > I have a question regarding configuring PCI with 44x.  Using 2.6.17-rc3
> as
> > > a reference, PCI_CONFIG is defined for the 44x defconfigs, and Kconfig
> is
> > > not enabled to reflect/change the setting for 44x.  When I update
> > > arch/ppc/Kconfig to enable configuring or not configuring PCI with 44x,
> and
> > > then don't configure it, the kernel won't compile:
> >
> > Hmm, you cannot disable PCI for 44x in the current 2.6. It's always
> > enabled.
> >
> > If you changed Konfig to be able to do so, why are you complaining
> > here? It's not enough to just change Konfig, you have to modify Ocotea
> > port as well. Look for example how this is handled for 85xx.
> >
> > Patches are welcome.
> >
> > --
> > Eugene
> >
> 
> I was first wondering if for some reason defaulting/forcing PCI to always
> be configured for 44x was intentional.

Yes. I think it's quite obvious from the way it's configured in 
Konfig.

>  I was second reporting the fact
> that if a change is made to not configure PCI for 44x, the kernel will not
> compile.

Well, I don't follow you here. You made the wrong change and report 
here that it broke the build. How is this interesting?

Your report looked as you discovered a bug, when in fact you broke the 
build yourself.

And again, if disabling PCI is important to you you are welcome to 
submit patches instead of sending misleading e-mails to this list.

-- 
Eugene
