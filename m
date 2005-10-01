Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 1543268432
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Oct 2005 18:24:15 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id 0415DA4017
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Oct 2005 10:24:13 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Sat, 1 Oct 2005 10:24:17 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<6eac69d46b656d812783d81a6ebeac84@embeddededge.com>
	<433E2530.7090503@iki.fi>
In-Reply-To: <433E2530.7090503@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510011024.17716.roger.larsson@norran.net>
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Saturday 01 October 2005 07.57, Kalle Pokki wrote:
> Dan Malek wrote:
> > I just built an 8250. 8260, and 8270 from a very recent 2.6 tree today
> > and they
> > all worked fine.  They all had different serial port configurations
> > (SMC1, SCC1
> > and SCC2).  Two were u-boot and one was a proprietary boot rom.
> > So, the "problem" seems to be related to something unique with your
> > system.
>
> Yes I'm sure the code in Linux is right. It may be missing some
> initialisation it depends on, but anyway.
>
> My board is an Embedded Planet EP8248 that came with a pre-installed
> version of Linux 2.4. That version works ok, though I don't know what
> modifications were made to the kernel. The source wasn't included...
>

That is a violation of the GPL license, developers could sue them for
copyright infringement.
(One other alternative is that you should have gotten info on how
to get the source)

/RogerL
