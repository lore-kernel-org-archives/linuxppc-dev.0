From: Ryan Nielsen <ran@krazynet.com>
Date: Fri, 2 Apr 1999 13:47:33 -0800
To: Sacha Varma <sacha@ssl.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP DayStar nPOWER
Message-ID: <19990402134733.B10812@gondolin>
References: <37049A1E.1596F185@ssl.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37049A1E.1596F185@ssl.co.uk>; from Sacha Varma on Fri, Apr 02, 1999 at 11:21:18AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sacha Varma <sacha@ssl.co.uk> wrote:
> 
> I have a DayStar nPower dual 604e daughtercard (in a PowerComputing
> PowerWave), for which it would appear there is currently no support in
> the kernel.
>
> How can I go about adding support for this?

just enable Symmetric multi-processing support in the Platform Support
section of config.

I don't use it because netscape (or X?) causes the machine to freeze too often.
which I'd like to fix..but i have no idea how to track what is causing it down.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
