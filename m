Date: Mon, 10 Jan 2000 14:08:32 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: linuxppc-dev@lists.linuxppc.org
cc: bh40@calva.net, olh@suse.de
Subject: Re: [patch] MacAlly 2-buttons mouse support for 2.2.14
In-Reply-To: <20000109204245.C17984@suse.de>
Message-ID: <Pine.LNX.4.21.0001101335111.22237-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 9 Jan 2000, Olaf Hering wrote:

> 
> We have also a nice mouse patch :-)
> 
.....
> 
> Right mouse button is CMND , middle mouse button is CTRL.
> Would be nice to get some feedback. 
> 
> 
> Gruss Olaf
> 


  Hmm how are you going to get double clicks with this ? 
Also keep in mind that many window managers/programs use
ctrl|meta|alt-mousebutton.

I still feel that at least for X it should (and can) be 
handled from inside X and not from the kernel. We still
need something for the console though.

 Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
