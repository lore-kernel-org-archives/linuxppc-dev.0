Date: Wed, 17 Feb 1999 23:38:21 -0500 (EST)
From: Thomas Riemer <triemer@apt4g.a3nyc.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Douglas Godfrey <dvdoug@tiac.net>, linuxppc-dev@lists.linuxppc.org
Subject: Food for thought
In-Reply-To: <Pine.HPP.3.96.990218032415.482P-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96.990217232756.31942A-100000@apt4g.a3nyc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hmmm... here's some food for thought... 

Suppose it were possible to have a distributed source control system...

By distributed, I mean the particular interesting properties:

1.  checkins all happen on a small number of machines/users...
     delegated by tree... i.e.
          linux/include   -> vger
          linux/arch/mips -> ftp.linux.sgi.com
      etc...

2.  checkouts all happen on mirrored machines...

Would that solve the problem?

-----------------------------------------------------------------------
Given enough eyeballs all bugs seem shallow.

On Thu, 18 Feb 1999, Gabriel Paubert wrote:

> 
> 
> 
> On Wed, 17 Feb 1999, Douglas Godfrey wrote:
> 
> > This sounds like a case for snail mail. If someone at one of the mirror
> > sites has a CD-ROM burner and can burn a CD from the current CVS tree
> > once a month. $5.00 plus $2.00 shipping and handling for a CD is probably
> > less than the Phone connection time charges to download the new updates
> > at 20 bytes/sec.
> 
> I'm on the education/research network so I don't pay for the connection. 
> And I often download between 3 and 5am like now when I'm up at the
> telescope, it's so much faster (up to 100kB/s). 
> 
> I don't know why but I feel like discriminated when the net approaches its
> saturation level :-). Strange enough, I have reasonably fast connection to
> the rest of Europe but the U.S. during daytime is simply hopeless (and the
> U.K. too, but traceroute enlighetened me once showing that the shortest
> path between Holland and London goes through New York and Washington, and
> that my notions of geography were hopelessly antiquated ;-))
> 
> However, my main point is that I am not going back to using vger under any
> circumstances (hmmm... if there were an incentive of a few million bucks,
> I might reconsider my position ;-))
> 
> 	Regards,
> 	Gabriel.
> 
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
