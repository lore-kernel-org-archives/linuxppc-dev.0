Subject: Re: [PATCH] 2.6 timebase synchronization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Samuel Rydh <samuel@ibrium.se>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <16181.43369.219750.258015@cargo.ozlabs.ibm.com>
References: <20030808001523.GA9274@ibrium.se>
	 <20030809011305.GA12030@ibrium.se>
	 <16181.43369.219750.258015@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1060508348.13388.20.camel@gaston>
Mime-Version: 1.0
Date: 10 Aug 2003 11:39:08 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-10 at 04:09, Paul Mackerras wrote:
> Samuel Rydh writes:
>
> > Attached is an improved version of the patch.
>
> How many SMP machines are there where we don't know how to freeze/thaw
> the timebase?  We know how to do that on the old powersurge powermacs,
> on CHRP systems and on at least some of the recent core99 powermacs
> (those that have a timebase-enable property on the cpu device nodes).
> What machines are left?

We know how to do it on some core99, though we don't actually do it
yet ;) We use software sync on all core99 for now.

Remaining are some older core99 machines, the 4-way DayStar oldworld
machines, and afaik, that's all...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
