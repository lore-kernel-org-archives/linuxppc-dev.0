Mime-Version: 1.0
Message-Id: <v04210103b3d66f64fb56@[192.168.0.1]>
In-Reply-To: <im1n1vz8a8x.fsf@chimera.sd.us.am.ericsson.se>
References: <im1n1vz8a8x.fsf@chimera.sd.us.am.ericsson.se>
Date: Tue, 10 Aug 1999 16:11:47 -0800
To: Brian Kidder <b.kidder@ericsson.com>, linuxppc-dev@lists.linuxppc.org
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: HFS+ support?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 10/8/99 Brian Kidder wrote:

>I know Apple's new HFS+ (aka HFS Extended) filesystem isn't currently
>supported in 2.2 (and apparently 2.3).  However, I've been able to
>find essentially zero information about HFS+ for Linux other than that.
>
>Are there current efforts to make this filesystem available?  If so,
>where can I find more information and possibly assist?  If not, what's
>the right way to start such an effort?

I believe that Apple has released some documentation on HFS+, I don't 
know if its enough to write a driver or not.  another possibility 
would be for someone to document HFS+ by using the APSL code that is 
part of Darwin, then someone else could write the driver.  (to avoid 
the risk of infecting GPL code with APSL code.)

>I currently have a PowerBook running linuxppc-1999, and would very
>much like to gain access to the Mac-side of the drive (no, going back
>to HFS isn't the right answer).  I am not that familiar with the
>filesystem guts of linux or the HFS module, but I'm very willing to
>dive in and try.



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
