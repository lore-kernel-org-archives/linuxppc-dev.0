Subject: Re: GLIBC wont compile for MPC860
To: scott@broadlink.com (Scott Wood)
Date: Tue, 31 Aug 1999 10:39:53 +1000 (EST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37CACCD3.91581C81@broadlink.com> from "Scott Wood" at Aug 30, 99 11:26:27 am
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19990831003953.707A564E@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Scott Wood writes:
> The MPC8xx have no floating point, so it should be compiled with -msoft-float,
> (I think)...  ./configure --without-fp  will do it.

Is this implied when gcc has been configured --with-cpu=860?

Thanks,
Graham

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
