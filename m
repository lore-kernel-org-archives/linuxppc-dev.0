Return-Path: <benh@kernel.crashing.org>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew McClintock <msm@freescale.com>
In-Reply-To: <1147960321.7607.9.camel@localhost.localdomain>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147930376.17679.72.camel@localhost.localdomain>
	<1147960321.7607.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:03:39 +1000
Message-Id: <1148623420.8089.70.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-18 at 08:52 -0500, Matthew McClintock wrote:

> Do you have any comments about how you envision updating the "virtual"
> mode image with information passed from the boot loader? I am asking
> this from the standpoint of updating the "virtual" flat tree with
> correct values, in order to boot from older firmware.

Well, that's what need to be discussed...  I'll read Mark replies and
others and will try to come up with my own comments/suggestions asap.
I'm a bit overflowed with stuff at the moment though.

Ben.
