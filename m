Message-ID: <39128A45.6C1BA8F1@wanadoo.fr>
Date: Fri, 05 May 2000 10:45:57 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
CC: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: 2.3.99-pre6 sound hfs
References: <Pine.LNX.4.10.10005042042280.19981-100000@shell.unixbox.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ani Joshi wrote:
>
> As some of you have said before, the HFS issue in 2.3 is due to all the
> VFS changes, page cache stuff being a big one.  anyhow, i poked around a
> bit last nite and have stabalized it a bit more (though not perfect yet),
> mounting and reads work fine, writes work sometimes and not, very strange.
>
> below is a patch which makes hfs use generic file read/writes, obviously
> more needs to be done then this, hopefully i'll post some more patches
> soon...

With this patch, I still cannot mount hfs CDs (the LinuxPPC 2000 CD),
and after a while of copying and gcc'ing on a hfs ZIP, it still freezes
the system. It seems, however, to survive somewhat longer than before,
and it freezes more gracefully, i.e. it puts me in a state (like vi
insert mode without Esc key) where I can type, even change consoles, but
it doesn't react. MagicSysRQ is still working, which wasn't the case
before.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
