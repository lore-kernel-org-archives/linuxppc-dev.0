Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 4 Mar 2003 08:26:55 -0600 (CST)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Ibon Gotxi Garcia <igotxi@jazzfree.com>
Cc: Wolfgang Denk <wd@denx.de>, Tom Rini <trini@kernel.crashing.org>,
	Jean-Denis Boyer <jdboyer@mediatrix.com>,
	Dan Malek <dan@embeddededge.com>,
	Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about modules
In-Reply-To: <1046783010.328.73.camel@muse>
Message-ID: <Pine.LNX.4.33.0303040826250.2281-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 4 Mar 2003, Ibon Gotxi Garcia wrote:
> I understand that reason, and i'm not certain about the usefulness of
> modules in embedded systems.

Modules are generally easier to debug.

>
> Anyway, my original purpose was to develop the driver as a module, and
> afterwards insert it into the kernel. I have just done it adding the
> EXPORT_SYMBOL macro to commproc.c and listing it in export-objs in
> arch/ppc/8xx_io/Makefile. Right, isn't it?
>
> Cheers.
>
> >
> > Wolfgang Denk
>
> --
> Ibon Gotxi Garcia <igotxi@jazzfree.com>
>
>
>

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
