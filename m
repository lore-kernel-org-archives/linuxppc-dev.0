Date: Mon, 10 Jan 2000 15:49:46 +0100
From: Olaf Hering <olh@suse.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] MacAlly 2-buttons mouse support for 2.2.14
Message-ID: <20000110154946.D7197@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <20000109204245.C17984@suse.de> <Pine.LNX.4.21.0001101335111.22237-100000@idd-01.imbc.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0001101335111.22237-100000@idd-01.imbc.gr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 10, Kostas Gewrgiou wrote:

> > Right mouse button is CMND , middle mouse button is CTRL.
> > Would be nice to get some feedback. 

>   Hmm how are you going to get double clicks with this ? 
> Also keep in mind that many window managers/programs use
> ctrl|meta|alt-mousebutton.
> 
> I still feel that at least for X it should (and can) be 
> handled from inside X and not from the kernel. We still
> need something for the console though.

It work also on the console. I guess there is no easy way for
ALT+double_click.

Or do you miss something? It is for the copy&paste function, I will
check what I can do to solve the problem with Xterm. You can not change
the size of the font.
If someone really need a application that depends on "complex mouse
clicks" ;-) then go and by a more button mouse.

BTW, where can I get a more button ADB mouse?


Gruss Olaf

-- 
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
