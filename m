To: Kevin Puetz <puetzk@iastate.edu>
cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Updated Mozilla M13 Release Build Available
In-reply-to: Your message of "Thu, 27 Jan 2000 13:46:40 CST."
             <E12DusK-0007We-00@puetz.penguinpowered.com>
References: <E12DusK-0007We-00@puetz.penguinpowered.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jan 2000 23:47:59 -0600
From: Kevin Puetz <puetzk@iastate.edu>
Message-Id: <E12E4GI-0001RX-00@puetz.penguinpowered.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In response to the problems that some of you had with my Mozilla M13 build,
here is an updated one. If there are no problems with it now, it will be
submitted and I will announce when the mozilla.org tarball is up to date.

same place as last time, I just updated the file <http://www.public.iastate.edu
/~puetzk/>

You will need to go to ftp.linuxppc.com/linuxppc-1999/software/updates and get
libstdc++-2.10.0 (and, of course, any dependencies it has). You should not
need to use the funky ld-hack to make libelf.so anymore - if you did so,
delete it. You should not need to run this version as root before running it
as a normal user.

If anyone could verify that this runs fine, please email me so that I can get
mozilla.org's FTP site up to date.

As before, I'm not on the linuxppc-dev list, so please CC me.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
