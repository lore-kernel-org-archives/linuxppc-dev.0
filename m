Message-ID: <3C44A85E.1090108@embeddededge.com>
Date: Tue, 15 Jan 2002 17:08:30 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Updegraff <dave@cray.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: a MINIMAL405 submodel
References: <3C44A4AF.9000302@cray.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Updegraff wrote:

> ... Might we be able to limit the proliferation of submodel
> in the PPC 4xx world with the addition of my proposed MINIMAL405
> submodel and then let vendors write drivers instead of kernels?

The 8xx and 8260 are almost like this.  What you will discover over
time is a driver you write is 99% of what someone else wants.  In your
proposal, you would end up with a whole new driver that is almost identical
to another, which isn't practical to maintain.  Just follow the convention
of adding a board descriptor for your platform.  If it is truly identical
to another, then the platforms can share the same files and this knowledge
is implicit in the configuration.  Now, if the current configurations make
assumptions about platforms that use a 405GP (and it shouldn't), that is
what needs to change.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
