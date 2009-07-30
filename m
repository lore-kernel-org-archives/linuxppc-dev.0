Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D529BB7BA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 00:04:57 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3259FDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 00:04:56 +1000 (EST)
Message-Id: <D19C1FEA-C06F-4958-979D-27FC9D52FADE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
In-Reply-To: <16444A0F3094A24C83EAB7836A12C63B032E5C@zin33exm20.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Thu, 30 Jul 2009 09:02:46 -0500
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
	<4A70A78D.7070601@gmail.com>
	<16444A0F3094A24C83EAB7836A12C63B032E5A@zin33exm20.fsl.freescale.net>
	<E8D39D04-E4B6-4420-AD54-6A95BE35EB30@kernel.crashing.org>
	<16444A0F3094A24C83EAB7836A12C63B032E5C@zin33exm20.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	Robert Hancock <hancockrwd@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 30, 2009, at 8:58 AM, Kalra Ashish-B00888 wrote:

> Hello Kumar,
>
> >> > This doesn't look like it should change anything. sata_fsl_ops
> >> inherits
> >> > from sata_pmp_port_ops, which inherits from sata_port_ops, which
> >> already
> >> > sets qc_defer to ata_std_qc_defer.
> >> Oh, yes. Actually this patch was for older kernels where there
> >> inheritence was not there. As you mentioned, this patch is not
> >> required now.
> >>
> >How old?  Should we be asking for this to be applied to some of the
> >stable kernel series?
>
> I believe that the inheritence stuff was added in 2.6.26, thus, this  
> patch is
> required for quite old kernels ( < 2.6.26 ).

Ok, than I'm not going to worry about it.

- k
