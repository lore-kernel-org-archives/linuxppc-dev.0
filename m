Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 13A2067BBD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 07:30:02 +1000 (EST)
Received: from icd.localnet (78.net216.skekraft.net [84.244.216.78])
	by mail.skekraft.net (Postfix) with ESMTP id 223D8A4076
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 22:58:31 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Allocalting > 4M
Date: Wed, 27 Sep 2006 22:58:26 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DF9C@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0189DF9C@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609272258.26835.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 27 September 2006 22:34, Rune Torgersen wrote:
> We have an embedded board with 1G of memory.
>
> Is there any way, short of using mem= on kernel command line and
> reserving memory, to allocate more than 4M of contigous physical memory?
> We're trying to allocalte a 8M buffer for use in some DMA transfers for
> a bank of DSP's.
> We were using get_Free_pages to allocate the meory before we made the
> buffer bigger. It seems that get_free_pages cannot allocate more than
> 2^10 pages (4M on ppc)
> I also tried alloc_bootmem, but it fails also.

There is a 'bigphysmem' patch for 2.4 that might help. There might be
alternative solutions to this problem, they should refere to bigphysmem
- might help when googling...

/RogerL
