Message-Id: <v03110709b5056af5e158@[129.100.29.243]>
In-Reply-To: <Pine.LNX.4.10.10003271120040.10719-100000@shell.unixbox.com>
References: <200003271913.OAA28080@mal-ach.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 27 Mar 2000 14:48:17 -0500
To: Ani Joshi <ajoshi@shell.unixbox.com>, David Edelsohn <dje@watson.ibm.com>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Some issues to resolve with XFree 4.0 yet
Cc: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani,

I asked the same things a few weeks back.  David is the epxert, I am not.
I think the key is what David just wrote:

>All of the inlined functions
>should have constraints which reference the actual memory address read or
>written to ensure proper dependencies in optimized code.

I think the memory constraint on the exact address prevents the compiler
from moving this inline code to someplace inappropriate, but David and
Gabriel could answer better.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
