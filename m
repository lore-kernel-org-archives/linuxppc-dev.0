Date: Thu, 11 Mar 1999 14:16:56 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: ADB Reset
Message-Id: <19990311141656.017582@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 11, 1999, Hubert Figuiere <hub@point-barre.fr> wrote:

>This is really ugly. Why the hell is mouse related code in the keyboard
>driver ? I may understand that since it is ADB they are related, but
>I find this not really clean.
>I'll look at this...

Historical reasons, I beleive. Anyway, I'm working on an overall rework
of the adb code (I finally have a little more time this week and for one
or two more weeks) that will allow ADB controller drivers and device
drivers to be in modules, and everything to be in different locations.

There is one advantage of having the mouse and kbd code mixed the way
they are currently which is to handle the mouse simulation via the kdb
without exporting all sorts of globals.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
