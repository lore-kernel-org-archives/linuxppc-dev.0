From: Ryan Nielsen <ran@krazynet.com>
Message-ID: <19990123230227.A625@gondolin>
Date: Sat, 23 Jan 1999 23:02:27 -0800
To: Paul.Mackerras@cs.anu.edu.au
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: kswapd and SMP still broke on 2.2.0-pre9
References: <Pine.LNX.4.04.9901222349480.17601-100000@narn.local.drgw.net> <199901232325.KAA18504@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199901232325.KAA18504@tango.anu.edu.au>; from Paul Mackerras on Sun, Jan 24, 1999 at 10:25:08AM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
> 
> Troy Benjegerdes <hozer@drgw.net> wrote:
> 
> > Can anyone verify 2.2.0-pre9 works on a SMP Pmac? (or for that matter,
> > vger.. if vger works I can figure out what changed)
> 
> Both 2.2.0-pre9 and vger work fine on my 2-processor powermac.  I do
> have some local changes in my tree to do with some extra memory
> barriers etc., but I haven't changed kswapd.  You could try rsyncing
> my current tree from samba.anu.edu.au::linux-pmac-devel to see my
> changes.

do you use scsi on your 2-processor powermac?
with the rsync'd tree it stops somewhere after printing the last line of this type:
Detected scsi disk sd%d at scsi%d, channel %d, id %d, lun %d
all the disks are on the MESH.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
