Date: Mon, 27 Mar 2000 11:38:37 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: David Edelsohn <dje@watson.ibm.com>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet 
In-Reply-To: <200003271945.OAA22150@mal-ach.watson.ibm.com>
Message-ID: <Pine.LNX.4.10.10003271136400.10993-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So does this mean all drivers (atyfb, aty128fb, xpmac to name a few) which
use method "b" should change to "a"?

ani



On Mon, 27 Mar 2000, David Edelsohn wrote:

> 	Method "a" says that the memory at the specified address was
> read/written.  Method "b" says that some unspecified piece of memory was
> affected and all future references to memory need to be reloaded to ensure
> that the correct value is used.
>
> David
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
