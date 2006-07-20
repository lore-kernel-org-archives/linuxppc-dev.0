Return-Path: <leisun124@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 8A04567B57
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 12:45:08 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id p77so395277nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 19:45:06 -0700 (PDT)
Message-ID: <f9a7e7a80607191945n7f0b95a9l3d6fe39a052b0f43@mail.gmail.com>
Date: Wed, 19 Jul 2006 22:45:06 -0400
From: "Lei Sun" <leisun124@gmail.com>
To: "Mathieu Deschamps" <mathieu.deschamps@com2gether.net>
Subject: Re: reboot on PQ2FADS board.
In-Reply-To: <200607191833.32693.mathieu.deschamps@com2gether.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4879B0C6C249214CBE7AB04453F84E4D050B0F@zch01exm20.fsl.freescale.net>
	<20060719063317.86A66352681@atlas.denx.de>
	<f9a7e7a80607190712v362c3e1ei7e85003041a25e35@mail.gmail.com>
	<200607191833.32693.mathieu.deschamps@com2gether.net>
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

On 7/19/06, Mathieu Deschamps <mathieu.deschamps@com2gether.net> wrote:
> Hi,
>
> On Wednesday 19 July 2006 16:12, Lei Sun wrote:
> > Hi :
> >   I  tried your approach last ight, (in fact I copied part of the
> > do_reboot() code from u-boot and put it in m8260_restart() function in
> > the kernel).  The only difference is the first line,
> >      volatile immap_t *immap = (immap_t *) IMAP_ADDR;
> > in my case it is
> >      volatile immap_t * immap = cpm2_immr;
> > I am using different source tree.
> > it simply hangs, rather then reset.
> >
> [...]
>
> Give a try to :
>         startaddr = 0xff000104;

That address was in the code before for warm-reset. It didn't work, I
tried the CheckStop approach, it didn't work either.

thanks
lei
