Date: Wed, 10 Mar 1999 09:43:53 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Hubert Figuiere <hub@point-barre.fr>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB Reset
In-Reply-To: <19990310123639.A292@giordino.point-barre.fr>
Message-ID: <Pine.LNX.3.96.990310093409.31597C-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 10 Mar 1999, Hubert Figuiere wrote:

> I could reset the adb bus with adb_reset_bus(), but it did
> nothing in my case. Mouse was still SLOW, etc.
> I called adb_scan_bus() instead. But this happen to not work and
> make my mouse no longer be recognized.
> 
> Any idea on what to do ?

If I were to venture a guess, I'd probably guess that the ADB power is
getting cut in sleep mode and the mouse is forgetting its acceleration
settings.  Have you tried changing the aceleration settings to see if that
resets it?  If not, the mouse's initialization routine might need to be
redone, if it isn't already....  Dunno.


David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
