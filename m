Date: Tue, 9 Feb 1999 11:55:28 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Meissner <meissner@cygnus.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Booting a PowerStack-II on a serial line
In-Reply-To: <199902071501.KAA01352@wogglebug.cygnus.com>
Message-ID: <Pine.HPP.3.96.990209114817.21099S-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sun, 7 Feb 1999, Michael Meissner wrote:

> 
> Is there any way I can tell at the shell level whether or not the
> PowerStack-II machine was booted via a serial line or with a
> monitor/keyboard?  I normally boot the machine via the serial line,
> and discovered that the gettys for the virtual console were respawning
> without end.  I edited the inittab to remove them, and put a normal
> login at 9600 baud on /dev/ttyS0 on runlevel 3, but was wondering if
> there was a way to switch automatically.

I don't think so. inittab is quite inflexible in this respect. I had
similar problems, tried to find a solution and failed. 

> Also, I found I can't compile with the console on a serial line and
> mac serial option (ie, can't use the common pmac/prep/mxb mode, I had
> to use the prep/mxb mode) due to both trying to define the same
> function.

I never enable mac serial support so I can't tell. But the pmac keyboard
has to be set to get the damned thing to compile unless CONFIG_VT is off.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
