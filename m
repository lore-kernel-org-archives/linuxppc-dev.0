From: SWStraus@aol.com
Message-ID: <3d996143.24d3d79c@aol.com>
Date: Sat, 31 Jul 1999 00:37:48 EDT
Subject: Re: solution for the Macally two button mouse
To: linuxppc@home.com
CC: linuxppc-dev@lists.linuxppc.org, p.a.padilla@larc.nasa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Try adding: 

xmodmap -e "pointer = 1 3 2" 

into your rc.local right under the mousemode statement.  It worked for me :o)
--
Steve


You Wrote:
> 
> Just discovered the handler for the Macally two button mouse. It is 66.
>
> In my rc.local I put "mousemode 3 66" command and now I can get the right
> button to respond.


Is there any away to make the second mouse button act as the other mouse
button (right now, it's the 'paste' button).

I've tried setting it up in WindowMaker WMPrefs.app, but it only seems to
take affect to the WM desktop, and NONE of the apps/icons.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
