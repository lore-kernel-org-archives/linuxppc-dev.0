From: Alan Mimms <alan@packetengines.com>
To: Dan Malek <dan@netx4.com>
Subject: Re: linuxppc-embedded: main kernel tree
Date: Wed, 26 Jan 2000 13:06:44 -0800
Content-Type: text/plain
Cc: Brendan.Simon@ctam.com.au,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
References: <388F3D65.3B420FED@ctam.com.au> <00012611055301.05597@alan.corp.packetengines.com> <388F4CCF.661A2D75@netx4.com>
In-Reply-To: <388F4CCF.661A2D75@netx4.com>
MIME-Version: 1.0
Message-Id: <00012613095603.05597@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you.  However, since I started out with the 2.2.13 sources and found
they just didn't work really at all on the CLLF (a driver bug somewhere?  I've
never done the diffs to try to find out.), I abandoned that approach and
relucantly went with the source tree you posted.  As you pointed out earlier
today, going with the real (ftp.kernel.org) source trees has huge advantages if
you can make it work for you.  But I failed on that path.

Now I'm wondering if I'll encounter the same sorts of difficulties with the
2.3.x kernel (2.3.18 might be the best place to start?).  Do you have a feeling
for whether the CLLF board will work with 2.3.18?  Certainly the 2.2.13 from
the ftp.us.kernel.org did NOT work, even configured precisely as your kernel
was configured.

Thanks very much, Dan.  You're helping me a LOT.  I hope someday to be able to
give back what I'm taking during this process, but I gotta get started first.

a

On Wed, 26
Jan 2000, Dan Malek wrote: > Alan Mimms wrote: >  > >
> > What kernel source version from the "main" tree actually builds and works
> > pretty well for most/all of the 8xx platforms?  I am particularly interested in
> > the CLLF supporting kernel.
>
> The last 2.3.xx kernel I used was 2.3.18.  Since I have customers
> building real products, all I have been using is 2.2.13.
>
> Recently, I have been trying to get 2.3.xx updated with 8xx
> modifications (like the FEC for the CLLF), but I have been
> spending time just making the current tree build properly.
>
> If you want 8xx that works, use the 2.2.13 kernel, and update
> the FEC driver from the source on ppc.kernel.org.  That is all
> I have been using for months.
>
>
> 	-- Dan
--
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
