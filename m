Message-Id: <v03130305b3ff80d77246@[192.168.1.1]>
In-Reply-To: <37D98144.97257D77@wanadoo.fr>
References: 
 <Pine.LNX.4.10.9909101143540.23282-100000@mercator.cs.kuleuven.ac.be>
 <37D944A8.78051BB@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Sep 1999 22:47:16 -0500
To: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: 2.3.18 and CONFIG_ADB_MOUSE
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:

>In the latest vger-2.3.18 and also Paul's linux-pmac-devel, the
>ADB_MOUSE cannot be selected any more, neither in 'make oldconfig' nor
>in 'make menuconfig'.
>
>While the logic in drivers/char/Config.in:
>
>if [ "$CONFIG_ADB" = "y" ; then
>    dep_tristate 'Apple Desktop Bus mouse support' CONFIG_ADB_MOUSE
>$CONFIG_BUSMOUSE
>
>looks OK, it doesn't work. This never shows up in 'make menuconfig'.

There's a missing ']' before the semi-colon '; then' if you copied that
verbatim.

If that's not the problem, then did you say "y" to ADB bus support (or did
it even ask)?

Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
