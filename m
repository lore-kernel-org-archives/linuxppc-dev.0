Date: Tue, 24 Aug 1999 11:02:29 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: BootX enhancement request
Message-Id: <19990824110229.025988@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 24, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:


>Yep.  There are two problems at the moment, which I should get off my
>butt and fix. :-)
>
>The first is that the current machines use a different structure for
>nvram, based on the CHRP spec, which means that just using a fixed
>offset in nvram doesn't work.  In fact it seems like macos adds a OF
>property with a really strange encoding to store arbitrary bits of
>information for the device drivers for arbitrary devices.
>
>The second is that macos is now using mode numbers > 20.  I haven't
>worked out the correspondence yet.

MacOS no longer relies on the nvram setting. Video drivers are free to
put whatever they want in their own device tree node, and usually store
an nvram value for the mode there, but this is proprietary and depends on
the driver. MacOS itself now stores the various infos in a preferences
file. The old "Monitors" control panel still updates the old pram
location with a mode value but the meaning is not guaranteed (can be
driver specific).

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
