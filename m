Message-ID: <607C84FE9FF8D211B6790090274D57F82FDC4F@Austin>
From: Ian Dale <idale@Crossroads.com>
To: "'Hollis R Blanchard'" <hollis+@andrew.cmu.edu>,
        Yann Bizeul
	 <yann@tynsoe.com>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: RE: X : caught signal 11 ?
Date: Tue, 20 Jul 1999 10:39:58 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know I'm fine on this... Start up into X, the screensaver works fine, and
I have full use of the virtual consoles... Running atyfb on an iMac 333.

-Ian Dale

-----Original Message-----
From: Hollis R Blanchard [mailto:hollis+@andrew.cmu.edu]
Sent: Tuesday, July 20, 1999 9:13 AM
To: Yann Bizeul
Cc: linuxppc-dev@lists.linuxppc.org; linuxppc-user@lists.linuxppc.org
Subject: Re: X : caught signal 11 ?



On Tue, 20 Jul 1999, Yann Bizeul wrote:
> 
> I've a little bit more informations.
> 1) X caught signal 11 and quits each time I go back to a console.
> 2) X quits each time XScreensaver is launching
> 
> Iuse the XFree server provided by Release 5

I also have problem 1), though I guess I've managed to disable xscreensaver
so
X does its built-in blanking thing (with no power saving =( ).

To crash X:
startx
ctrl-cmd-F1

Poof. All gone. If you have xdm set up, xdm reloads (and takes you to vc 7
from wherever you wanted to go in the first place). I'm using platinumfb. Is
anyone else out there able to use virtual consoles without X crashing?

-Hollis


[[ This message was sent via the linuxppc-user mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-user  if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
