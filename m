Date: Mon, 21 Dec 1998 00:23:10 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Alois Fertl <alois_fertl@TalkNet.de>
cc: Gabriel Paubert <paubert@iram.es>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: preploader (re:Linux-2.1.129 boot on MCP750)
In-Reply-To: <367CBE74.A3DDAF22@talknet.de>
Message-ID: <Pine.LNX.4.04.9812210021020.21549-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 20 Dec 1998, Alois Fertl wrote:

> 
> I have successfully booted the following systems using the preploader 
> and a selfcompiled 2.1.130 kernel:
>    RiscPC 603 66MHz
>    RiscPC 604 133MHz
>    RiscPC Plus 604 133MHz
> All onboard PCI devices are detected and configured.
> 
Are these Motorola Boards? I have a 604/133 which I believe to be a
BlackHawk board, with on-board Cirrus logic chip, and the preploader
screws up the video display and doesnt' boot. (This was with Gabiel's
version.)

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
