Date: Sun, 22 Aug 1999 16:20:18 -0400
From: Kevin Puetz <puetzk@iastate.edu>
To: brad allison <jackal@aol.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
Message-ID: <19990822162018.B24436@puetz.penguinpowered.com>
Reply-To: Kevin Puetz <puetzk@iastate.edu>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does your machine not have a video driver? If you can avoid no video driver mode, this should not be needed (use Xconfigurator to setup multiple resolutions).

On the other hand, though, this would be nice for those who don't have supported video (like B&W G3's, or is the new 128 driver usable already?)

On Sun, 22 Aug 1999 13:45:27 brad allison wrote:
> 
> 
> I'm not sure how hard/not hard this would be to do, but right now in order
> to change resolutions I have to boot into MacOS, set my resolution, launch
> BootX, boot into init 3, run Xautoconfig, boot into init 5.
> 
> That's a lot of work to just change the resolution for X.
> 
> It would be nice if you could set the resolution and color from BootX on
> boot up.
> 
> If there's a easier way to change pixel depth and resolution from inside X
> please let me know....
> 
> -b
> 
> --
> AOL SAPI 		                        703.265.0908     AIM:jackal242
> http://jackal.fudge.org        `I was never more certain of how far away I was
> from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
