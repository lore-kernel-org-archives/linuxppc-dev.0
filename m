Message-ID: <369BB46B.206BB152@d.umn.edu>
Date: Tue, 12 Jan 1999 14:45:33 -0600
From: Nathan Ingersoll <ningerso@d.umn.edu>
MIME-Version: 1.0
To: satadru pramanik <satadru@umich.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: GPM services nonfunctional on linuxppc/Redhat
References: <Pine.LNX.4.05.9901121044140.8499-100000@beer.pub.umich.edu>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It works fine with my one button mouse. I think your problem is that the
kernel isn't emulating 3-buttons. Pass the argument adb_buttons=113,115 to
use F15 as button 2 and Home as button 3. You can change these values to use
different keys.

satadru pramanik wrote:

> Gpm fails to work on my system because I use the standard Apple on ebutton
> mouse type.  Interestingly, gpm seems to load only after i quit x-windows.
> Is gpm part of one of the default Xwindows scripts? Also, has anybdy
> gotten gpm working functionally with a one button mouse?
>
> ----
> satadru pramanik `satadru@umich.edu'
> "Put your hand on a hot stove for a minute, and it seems like an hour. Sit
> with a pretty girl for an hour, and it seems like a minute. THAT'S
> relativity."
> -Albert Einstein
> ---


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
