Message-ID: <38CB8F80.8A64B8CC@wanadoo.fr>
Date: Sun, 12 Mar 2000 13:37:20 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: andreas tobler <toa@pop.agri.ch>
CC: Linuxppc-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: defconfig for pmac in 2.3.51 and up
References: <38CB649E.7B7F426@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


andreas tobler wrote:
>
> Hi all,
>
> maybe a dump Q, but I don't find it. In the kernels before 2.3.51 (stable &
> devel) I could type 'make pmac_config' to get the most things set to my needs.
> Now in 2.3.51 this defconfig is away.
> Any idea? Neither on bitkeeper nor on linuxcare. Or are there new methods to
> make defconfigs for certain machines?
> I don't like to set every item by hand. (too much)

Strange... When I say 'make pmac_config' in the 2.3.51 tree from
bitkeeper, it does
rm -f .config arch/ppc/defconfig
cp -f arch/ppc/configs/pmac_defconfig arch/ppc/defconfig

The only thing that changed from older kernels is that the config files
now have their own subdirectory arch/ppc/configs/. But this should work
precisely as before.

(digging a little further...) Oh I see, bitkeeper doesn't have the
complete collection of arch/ppc/configs/*_defconfig files any more; no
more chrp, pmac, or prep. I still have them from a previous version.
Weird...



--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
