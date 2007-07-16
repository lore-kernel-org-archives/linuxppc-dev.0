Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id 107A7DE348
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 01:44:04 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so852712nzf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jul 2007 08:44:03 -0700 (PDT)
Message-ID: <fa686aa40707160844x3bc31c4cw658bb6e4b2cb3bd7@mail.gmail.com>
Date: Mon, 16 Jul 2007 09:44:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: khollan <khollan@daktronics.com>
Subject: Re: ML410 PCI support
In-Reply-To: <11620099.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11547023.post@talk.nabble.com> <11620099.post@talk.nabble.com>
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

On 7/16/07, khollan <khollan@daktronics.com> wrote:
>
>
> khollan wrote:
> >
> > I have two questions:
> > 1) Has anyone wrote linux 2.6 PCI drviers for the xilinx development
> > boards.  I want to get the PCI slots working on my board.
> > 2)How do I set the HwAddr for the TEMAC driver?  Im using Grants latest
> > git tree.  My board boots and the HwAddr is set to 00:00:00:00:00:00
> > Thanks for your help
> > Kevin
> >
>
> 1) Still waiting to see if someone knows how to go about doing this...

No, I don't think anyone has done proper PCI support.  But you might
want to double check the MontaVista 2.4 tree.

> 2) Solved this by hardcoding it in the embed_config.c file

Which is probably the best way to do it if you're booting from a
zImage.  If you're booting from u-boot or another bootloader, you can
pass the addr in the board info structure.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
