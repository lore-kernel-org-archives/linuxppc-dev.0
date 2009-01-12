Return-Path: <bzolnier@gmail.com>
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/9] sl82c105: remove dead code
Date: Mon, 12 Jan 2009 18:59:47 +0100
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
	<20090106183526.21193.24866.sendpatchset@localhost.localdomain>
	<496A613F.5090901@ru.mvista.com>
In-Reply-To: <496A613F.5090901@ru.mvista.com>
MIME-Version: 1.0
Message-Id: <200901121859.48001.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 11 January 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > CONFIG_LOPEC and CONFIG_SANDPOINT config options are gone.
> >   
> 
>   So these are gone with arch/ppc/?

Yep.

>   That's a pity -- MV has spent a lot of efforts on porting the latter 
> to arch/powerpc/ but somehow it haven't got merged upstream. My patches 
> ot this driver were actually due to it being used on Sandpoint. :-)

Heh, and I cleaned ppc IDE hooks just before these platforms were removed
(that's how these ifdefs got into sl82c105.c). :-)

Thanks,
Bart
