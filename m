Message-ID: <37C15204.47BADD90@jeol.com>
Date: Mon, 23 Aug 1999 09:52:14 -0400
From: Mike Lambert <lambert@jeol.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
References: <Pine.SGI.4.00.9908221341390.4744-100000@osiris.office.aol.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




brad allison wrote:
> 
> I'm not sure how hard/not hard this would be to do, but right now in order
> to change resolutions I have to boot into MacOS, set my resolution, launch
> BootX, boot into init 3, run Xautoconfig, boot into init 5.

One way would be to add a line to your rc.local file to check for and
run Xautoconfig automatically on startup.

> It would be nice if you could set the resolution and color from BootX on
> boot up.

This would require using  a video hw specific driver such as "atyfb" or "aty128fb".
 
-mike

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
