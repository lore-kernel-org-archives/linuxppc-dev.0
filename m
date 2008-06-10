Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910806101044u1dd79185vc40f5c66e82edbfb@mail.gmail.com>
Date: Tue, 10 Jun 2008 13:44:47 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Robert Schwebel" <r.schwebel@pengutronix.de>
Subject: Re: Image generation for Efika is broken in 2.6.26
In-Reply-To: <20080610165719.GA5139@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806100738rac8e415x99f6e96715ebee90@mail.gmail.com>
	<20080610165719.GA5139@loki.buserror.net>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/10/08, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, Jun 10, 2008 at 10:38:31AM -0400, Jon Smirl wrote:
>  > Why is my vmlinux.strip 3.2GB? Could a missing address be interpreted
>  > as -1 (0xFFF..) and cause the image to contain all of memory?
>  >
>  > -rw-r--r--  1 jonsmirl jonsmirl   61738015 2008-06-10 10:31 vmlinux.o
>  > -rwxr-xr-x  1 jonsmirl jonsmirl 3224175192 2008-06-10 10:31 vmlinux.strip.3651
>  >
>  > After it is packed vmlinux is 32MB. Packing gigabytes of zeros, maybe?
>  >
>  > -rwxr-xr-x  1 jonsmirl jonsmirl 32430673 2008-06-10 10:31 vmlinux
>  >
>  > This image won't load onto the Efika probably because it is trying to
>  > expand back to 3.2GB.
>  >
>  > With the same .config vmlinux is 4.1MB on 2.6.25
>  >
>  > -rwxr-xr-x  1 jonsmirl jonsmirl 4119174 2008-06-09 20:09 vmlinux
>
>
> Are you using binutils 2.17?  It has a bug that was triggered by the p_paddr
>  change.  Do you get a bunch of warnings from the strip command?

I don't see any warnings even when run make V=1.

I'm using the Pengutronix OSELAS.Toolchain-1.1.1 which has bunutils 2.17 in it.

I'm trying to convince OSELAS to rebuild the toolchain on Ubuntu hardy
but I'm having problems.

>
>
>  -Scott
>


-- 
Jon Smirl
jonsmirl@gmail.com
