Message-ID: <20020921142733.24474.qmail@kunk.jriver.com>
Subject: Re: cdrecord, cdrdao failing with scsi bus reset
In-Reply-To: <20020921142023.24406.qmail@kunk.jriver.com>
To: linuxppc-dev@lists.linuxppc.org
Date: Sat, 21 Sep 2002 09:27:33 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: benh@kernel.crashing.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> benh@kernel.crashing.org ("Benjamin Herrenschmidt") Said:
>
> > Robert Brose said:
> >I got it off of this list myself, I think it was originally for
> >2.4.3. I've just kept remaking it as I put new kernels on
> >my machine as it seems to never have made it to the official
> >kernel. It patches several scsi drivers but the only ones that
> >affect Mac users are  the 53c94 and mesh drivers.
> >
> >http://www.jriver.com/~bob/daofix-2.4.17.diff
> >
> >Is against the 2.4.17 kernel. I just tried it on the latest
> >benh 2.4 kernel (2.4.20-pre7) and it patched ALTHOUGH there
> >were offsets in the mesh driver which seems to have been worked
> >on lately. I haven't verified that it works past the 2.4.19
> >kernel I'm currently using. YMMV.
>
> Interesting. I don't think this patch does things the right
> way though, but I'll see what I can do with it.
>
> Ben.

If I remember right the author of the patch was trying to reduce
the redundancy of the same code in several scsi drivers and do
a more generic setting of the scsi direction flag. This is a pretty
common problem, I've seen the same limitation in the Adaptec 3200
driver as well as in other OS. It would be great if some kind
of fix got into the main tree, THANKS!!

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
