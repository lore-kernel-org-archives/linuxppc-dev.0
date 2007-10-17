Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1886DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 05:48:11 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9HJm62f014508
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 15:48:06 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9HJm1h9458676
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 13:48:02 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9HJm1MY016433
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 13:48:01 -0600
Date: Wed, 17 Oct 2007 14:47:59 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: loading NOR flash from DT
Message-ID: <20071017144759.320209bd@weaponx.rchland.ibm.com>
In-Reply-To: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>
References: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 17 Oct 2007 21:26:51 +0200
Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc> wrote:

> Hello,
> 
> I have here a MPC8544 DS board with NOR flash on it and Kumar's git
> tree. I'm trying to detect this flash with the physmap_of module. I
> added a nor_flash block (I used sequoia.dts as an example) into my
> device tree on the same level as soc8544 or memory (or between them).
> After modprobing physmap_of nothing happend. Then I tried to make a tree
> with plb -> opb -> ebc and finally nor_flash but still nothing changed.
> 
> Is there a user space dependency or did I just edit my device tree the
> wrong way? Any hints are welcome :)

Post your device tree please.  I don't recall MPC8544 even having PLB,
OPB, or EBC busses, so they likely aren't getting probed.

josh
