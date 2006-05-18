Return-Path: <msm@freescale.com>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
From: Matthew McClintock <msm@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1147930376.17679.72.camel@localhost.localdomain>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147930376.17679.72.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 May 2006 08:52:01 -0500
Message-Id: <1147960321.7607.9.camel@localhost.localdomain>
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

Do you have any comments about how you envision updating the "virtual"
mode image with information passed from the boot loader? I am asking
this from the standpoint of updating the "virtual" flat tree with
correct values, in order to boot from older firmware.

-Matthew 

On Thu, 2006-05-18 at 15:32 +1000, Benjamin Herrenschmidt wrote:
> That is why, I think, what we should do is have rules for building
> separate zImage wrappers. The basic OF one (which exists in both real
> and virtual mode versions and that I'd like to make capable of also
> working if a flat device-tree is passed in), the zImage.sandpoint, the
> zImage.prep, and whatever...
> 
