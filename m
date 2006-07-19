Return-Path: <mathieu.deschamps@com2gether.net>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by ozlabs.org (Postfix) with ESMTP id 9C70B67B89
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 02:39:16 +1000 (EST)
From: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
To: "Lei Sun" <leisun124@gmail.com>
Subject: Re: reboot on PQ2FADS board.
Date: Wed, 19 Jul 2006 18:41:46 +0200
References: <4879B0C6C249214CBE7AB04453F84E4D050B0F@zch01exm20.fsl.freescale.net>
	<20060719063317.86A66352681@atlas.denx.de>
	<f9a7e7a80607190712v362c3e1ei7e85003041a25e35@mail.gmail.com>
In-Reply-To: <f9a7e7a80607190712v362c3e1ei7e85003041a25e35@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200607191833.32693.mathieu.deschamps@com2gether.net>
Content-Type: text/plain;
  charset="iso-8859-1"
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

Hi,

On Wednesday 19 July 2006 16:12, Lei Sun wrote:
> Hi :
>   I  tried your approach last ight, (in fact I copied part of the
> do_reboot() code from u-boot and put it in m8260_restart() function in
> the kernel).  The only difference is the first line,
>      volatile immap_t *immap = (immap_t *) IMAP_ADDR;
> in my case it is
>      volatile immap_t * immap = cpm2_immr;
> I am using different source tree.
> it simply hangs, rather then reset.
>
[...]

Give a try to :
	startaddr = 0xff000104;



-- 
Mathieu Deschamps
Com2gether Design Center
Electronic and Embedded Engineering Services
www.com2gether.net 
