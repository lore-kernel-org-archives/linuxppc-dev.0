Subject: Re: ibook2 will not wake from sleep on 2.4.20-ben7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Blanton <eblanton@cs.ohiou.edu>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030301234940.GB6120@paco.resnet.purdue.edu>
References: <20030301202916.GA6120@paco.resnet.purdue.edu>
	 <1046557102.2030.89.camel@zion.wanadoo.fr>
	 <1046557625.2030.91.camel@zion.wanadoo.fr>
	 <20030301234940.GB6120@paco.resnet.purdue.edu>
Content-Type: text/plain
Message-Id: <1046597586.2019.93.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 02 Mar 2003 10:33:06 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-03-02 at 00:49, Ethan Blanton wrote:
> Benjamin Herrenschmidt spake unto us the following wisdom:
> > > Can you try -ben4 or -ben5 ? Patches against official 2.4.20
> > > are on kernel.org/pub/linux/kernel/people/benh.
> >
> > Hrm... before that, try this patch against -ben7
>
> You're the man, Ben.  :-)  This patch seems to work perfectly.  I
> assume you are not interested in the results from -ben4 and -ben5?  (I
> can still check.)

You assume correctly. I'll release -ben8 early next week with
that fix.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
