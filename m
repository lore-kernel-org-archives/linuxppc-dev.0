Subject: Re: unkillable zombies from using gdb and kernel 2.4.15 and higher?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <CF1E527E-ED77-11D5-8C12-0030654D6A26@ivey.uwo.ca>
References: <CF1E527E-ED77-11D5-8C12-0030654D6A26@ivey.uwo.ca>
Content-Type: text/plain; charset=ISO-8859-1
Date: 10 Dec 2001 20:39:13 +0100
Message-Id: <1008013153.17478.28.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2001-12-10 at 15:11, Kevin Hendricks wrote:

> So these zombies are ignoring kill -9  signals which I thought was a big
> no-no?

Zombies are dead, they don't get more dead if you kill them. ;)

AFAIR zombies have died but are waiting for their return value to be
read out of the process table. I'd like to know myself how that can
happen when their parents are gone...


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
