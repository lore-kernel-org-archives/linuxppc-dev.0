Message-Id: <200003271945.OAA22150@mal-ach.watson.ibm.com>
To: Ani Joshi <ajoshi@shell.unixbox.com>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet 
In-Reply-To: Message from Ani Joshi <ajoshi@shell.unixbox.com>
   of "Mon, 27 Mar 2000 11:25:18 PST." <Pine.LNX.4.10.10003271120040.10719-100000@shell.unixbox.com>
Date: Mon, 27 Mar 2000 14:45:57 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Method "a" says that the memory at the specified address was
read/written.  Method "b" says that some unspecified piece of memory was
affected and all future references to memory need to be reloaded to ensure
that the correct value is used.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
