Date: Sat, 14 Aug 1999 18:32:29 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: "Brian K. Neidig" <brian.neidig@natinst.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: What is the NIP?
In-Reply-To: <37B60738.E1E4B2F7@natinst.com>
Message-ID: <Pine.LNX.3.96.990814182915.29538B-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 14 Aug 1999, Brian K. Neidig wrote:

> I've looked throughout the code for a comment describing this, but
> couldn't find it.  What is the purpose of the NIP?  I think it is NOT
> QUITE the IP, but I don't know what it is supposed to be.  In one place
> I saw the NIP being set to the instruction before a branch instruction,
> but other things seem to be happening with this variable.

AFAIK, it's "next instruction pointer".  IOW, it points to whatever
instruction is supposed to be looked at by the processor next.  A branch
would thus change this, as I assume an interrupt would, but I'm not 100%
positive about that.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
