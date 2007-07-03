Return-Path: <dale@farnsworth.org>
Date: 2 Jul 2007 19:31:18 -0700
Message-ID: <20070703023118.30095.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: bgholikh@cisco.com, Linuxppc-embedded@ozlabs.org
Subject: Re: help on dts compiler please.
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A45A@xmb-sjc-212.amer.cisco.com>
References: <1183426404.5643.0.camel@vader.jdub.homelinux.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > > $ dtc -f -I dts -O dtb mpc8541cds.dts
> > > DTC: dts->dtb  on file "mpc8541cds.dts"
> > > syntax error at line 15
> > > FATAL ERROR: Couldn't read input tree
> > 
> > Where did you get your dtc version from?
> > 
> Sorry I answered the question wrong. I downloaded the gzip tar file from
> David Gibson web page.

That same web page says that the latest version of the web page is
at git://www.jdl.com/software/dtc.git

Try the current version available there.

-Dale Farnsworth
