Message-ID: <20020921052807.20546.qmail@kunk.jriver.com>
Subject: Re: cdrecord, cdrdao failing with scsi bus reset
In-Reply-To: <Pine.LNX.4.33.0209192356070.1980-100000@localhost.localdomain>
To: Tony Howard <tahoward@ntrnet.net>
Date: Sat, 21 Sep 2002 00:28:07 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got it off of this list myself, I think it was originally for
2.4.3. I've just kept remaking it as I put new kernels on
my machine as it seems to never have made it to the official
kernel. It patches several scsi drivers but the only ones that
affect Mac users are  the 53c94 and mesh drivers.

http://www.jriver.com/~bob/daofix-2.4.17.diff

Is against the 2.4.17 kernel. I just tried it on the latest
benh 2.4 kernel (2.4.20-pre7) and it patched ALTHOUGH there
were offsets in the mesh driver which seems to have been worked
on lately. I haven't verified that it works past the 2.4.19
kernel I'm currently using. YMMV.

Bob

User Tony Howard says:
>
> Do you know where I could find this patch (or who wrote it?)
>
> Tony
>
> On Fri, 20 Sep 2002, Robert E Brose II wrote:
>
> >
> > DAO doesn't work with the stock scsi drivers (at least not through
> > 2.4.18). You need to apply a patch to the kernel drivers to get
> > it working otherwise use tao.
> >
> > Bob
> > --
> > /~\ The ASCII       | Robert E. Brose II    N0QBJ
> > \ / Ribbon Campaign | http://www.qbjnet.com/
> >  X  Help cure       | mailto:bob@qbjnet.com
> > / \ HTML Email      | public key at http://www.qbjnet.com/key.html
> >
> >
>
>

--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
