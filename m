Message-ID: <38CB94D1.C443C343@pop.agri.ch>
Date: Sun, 12 Mar 2000 14:00:02 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>
CC: Linuxppc-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: defconfig for pmac in 2.3.51 and up
References: <38CB649E.7B7F426@pop.agri.ch> <38CB8F80.8A64B8CC@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Martin Costabel wrote:
>
> andreas tobler wrote:
> >
> > Hi all,
> >
> > maybe a dump Q, but I don't find it. In the kernels before 2.3.51 (stable &
> > devel) I could type 'make pmac_config' to get the most things set to my needs.
> > Now in 2.3.51 this defconfig is away.
> > Any idea? Neither on bitkeeper nor on linuxcare. Or are there new methods to
> > make defconfigs for certain machines?
> > I don't like to set every item by hand. (too much)
>
> Strange... When I say 'make pmac_config' in the 2.3.51 tree from
> bitkeeper, it does
> rm -f .config arch/ppc/defconfig
> cp -f arch/ppc/configs/pmac_defconfig arch/ppc/defconfig
>
> The only thing that changed from older kernels is that the config files
> now have their own subdirectory arch/ppc/configs/. But this should work
> precisely as before.
>
> (digging a little further...) Oh I see, bitkeeper doesn't have the
> complete collection of arch/ppc/configs/*_defconfig files any more; no
> more chrp, pmac, or prep. I still have them from a previous version.
> Weird...

On bitkeeper they're lost a longer time, but on linuxcare only since the
latest update from 48 to 51. Normally I wouldn't recognize such things,
but since I enabled the --delete option in rsync, such files, which are
no longer present, are deleted. Maybe the same happened to
linuxcare-pmac-devel when syncing with bitkeeper??
I have the files around on an other machine, but I agree; weird

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
