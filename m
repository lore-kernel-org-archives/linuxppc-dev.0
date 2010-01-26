Return-Path: <Dan.Geer@faa.gov>
Received: from relay2.faa.gov (relay2.faa.gov [204.108.10.7])
	by ozlabs.org (Postfix) with ESMTP id D2740B7D79
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jan 2010 10:28:08 +1100 (EST)
In-Reply-To: <4B5F6A11.70409@freescale.com>
Subject: Re: BSE-IP
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF55040149.583E5B45-ON852576B7.007DD263-852576B7.0080E890@faa.gov>
From: Dan.Geer@faa.gov
Date: Tue, 26 Jan 2010 18:28:01 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > I have the 2.2 pre7 from BSE, but there have been a few changes
since. ;^)
>
> Hopefully not changes in the board. :-)

Hardware is standard.

> That kernel should still work for extracting any knowledge about the
> board's hardware that may or may not be clear from its documentation.

Yeah, I have some more homework todo.  I've looked at the device tree
documentation (I think you wrote) and will be getting to that.

> > It appears the image (bootwrapper) needs to be completely
self-contained,
> > and needs to understand how to read the flash parameters.  That's on my
> > list.
>
> What firmware is on the board?

Great question!  I have no idea!  BSE has some specific factory bootstrap.
It supports tftp, fsets, fgets, and a go <address>...  it's blackbox from
there to the kernel start.  BSE supplied a bootlo.bin file in their build
chain, but I haven't figured out the source yet.  It unzips the kernel,
ramdisk, and supplies the old bd_info pointer to the kernel as it bounces
into the kernel start.  I guess I still have my work cut out for me.

Thanks for the advice!
