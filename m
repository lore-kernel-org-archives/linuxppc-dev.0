Date: Mon, 1 Feb 1999 11:34:29 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Gabriel Paubert <paubert@iram.es>
cc: David De Ridder <david.de.ridder@bitsmart.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on MVME 2306 board
In-Reply-To: <Pine.HPP.3.96.990201140400.16636D-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96.990201113120.32358B-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, Gabriel Paubert wrote:

> > As I understand from some messages in this list, several people have
> > been able to run LinuxPPC on such boards.
> 
> At least simliar ones, I don't remember exactly what the 230x has. But as
> long as it has a DEC21x4x Ethernet, there should not be any problem...

One note: there is a problem with DEC21143 support in the current de4x5
driver that causes the MVME2300sc and 2400 to crash on driver init.  I'm
still chasing this...These are these only MVME boards with major problems
under Linux (unless you don't build in Ethernet support).

--
Matt Porter
mmporter@home.com
Unix is a Linux-like operating system.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
