Message-ID: <39D10BB4.D6F1897@charter.net>
Date: Tue, 26 Sep 2000 15:48:52 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Navin Boppuri <nboppuri@trinetcommunication.com>
CC: linuxppc-embedded@lists.linuxppc.org, greyham@research.canon.com.au
Subject: Re: NFS problem- neighbout table overlow
References: <018601bfc7e6$30ab9560$4a1f76d8@washington>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin Boppuri wrote:
> Hello Everyone,
> I have been having problems with my custom board. The NFS mount does
> not
> work. The NFS request does not actually go the server. I dont see any
> packets coming to the server from this board. I did have some ring
> dump
> problems. There were some errors in Port A setting which I fixed and
> that is
> gone now. By I still see 'neighbour table overflow' messages. What can
> be
> the problem?

Navin,
I can't say that I remember for sure - but I seem to recall
this as being a problem in the Linux NFS implementation.
Check through the linux-kernel archives for messages regarding
the neighbour table overflow.  There may be a suggestion
on how to solve this.  I know I remember something about this...
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
