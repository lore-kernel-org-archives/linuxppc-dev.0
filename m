Subject: Re: PREEMPT on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <13b501c41283$7e2ab3c0$3cc8a8c0@epro.dom>
References: <1080197240.1210.2.camel@gaston>
	 <1080201697.1217.3.camel@gaston>  <13b501c41283$7e2ab3c0$3cc8a8c0@epro.dom>
Content-Type: text/plain
Message-Id: <1080254519.1217.42.camel@gaston>
Mime-Version: 1.0
Date: Fri, 26 Mar 2004 09:42:00 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-03-26 at 03:09, Colin Leroy wrote:
> Hi Ben!
>
> > + *
> > + * 24/03/2004 - BenH: Bump that limitation to 512k and remove the
> > + *                    filter for the MacOS drivers as we may now run
> > + *                    those in a shell
> >   */
> > -#define MAX_PROPERTY_LENGTH 4096
> > +#define MAX_PROPERTY_LENGTH (512 * 1024)
>
> It doesn't look like related to preempt, but it actually interests me :)
> Is it a work in progress ? And most importantly ;), does it enable us to
> reboot a radeon 9200 after sleep ?

It's a work in progress, and it will not work for nVidia's unless you
can find the "old" PEF driver for them somewhere. For ATIs the "PEF"
driver has to be extracted from MacOS X. It's not complete yet, I'll
post some announce when that's done.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
