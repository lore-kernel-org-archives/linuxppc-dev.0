Date: Tue, 10 Oct 2000 20:44:14 +0200
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Safe shutdown on IDE boot
Message-ID: <20001010204414.B8373@hectic.net>
References: <Pine.HPX.4.10.10010101011400.16113-100000@gra-ux1.iram.es> <39E341BC.9D8FD69B@mvista.com> <39E35991.F45DF673@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39E35991.F45DF673@emc.com>; from zzhu@emc.com on Tue, Oct 10, 2000 at 02:01:53PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Zhaobin!

On Tue, Oct 10, 2000 at 02:01:53PM -0400, you wrote the following:

> I boot Hardhat linux on IDE disk on sp7400.
>
> But I can boot it only once.  The next time I boot,
> I see
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 284k init
>
> and hangs there.
>
> I put the disk back to Host and found some problem with fs on this disk
> and I can fix it by "e2fsck".
>
> I guess i had problem with safely shutdown.
> Anybody knows how to do the "shutdown" safely ?

I have the exact same problem when I boot without an HD but with NFS
root over the network. So I don't think it has to do with shutting
down properly. All eyes to our MAG and Wizard. ;-)


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

I drive way too fast to worry about cholesterol.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
