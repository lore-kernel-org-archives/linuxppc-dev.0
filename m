Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from c07.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id D2C26DDF5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Oct 2007 17:57:34 +1000 (EST)
In-Reply-To: <f8f856500709130705t2109e559v19f0ffac318a4756@mail.gmail.com>
Subject: DMA problem - mpc8xx
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF0ED90B65.60296006-ONC125737D.0028DB92-C125737D.002A55F3@abengoa.com>
Date: Tue, 23 Oct 2007 09:42:43 +0200
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I am having problems with the serial cpm driver in a mpc866. But I've f=
ound
out that my problem comes from the DMA and not really from the driver. =
 The
Rx and Tx buffers use the DMA and then the sytem hangs. However, if I s=
et
these buffers to internal ram memory (DPRAM), it works. The DMA address=
 is
configured with a kernel parameter in advance setup:
CONFIG_CONSISTENT_START (and the size in CONFIG_CONSISTENT_SIZE), but I=

don't know what they are exactly and I could not find a right documenta=
tion
about it.
I saw a pair of mailing list where some guys set the
CONFIG_CONSISTENT_START to 0xff100000, but my driver continues failing =
(and
an error about dma-mapping appears in the boot).

Did anyone have a similar problem?
Could anyone help me?

Thanks in advance,

Ra=FAl Moreno=
