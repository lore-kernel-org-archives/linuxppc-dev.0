Date: Mon, 10 Dec 2001 21:20:03 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: unkillable zombies from using gdb and kernel 2.4.15 and higher?
In-Reply-To: <1008013153.17478.28.camel@pismo>
Message-ID: <Pine.LNX.4.33.0112102117570.24633-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 10 Dec 2001, Michel [ISO-8859-1] Dänzer wrote:

>
> On Mon, 2001-12-10 at 15:11, Kevin Hendricks wrote:
>
> > So these zombies are ignoring kill -9  signals which I thought was a big
> > no-no?
>
> Zombies are dead, they don't get more dead if you kill them. ;)
>
> AFAIR zombies have died but are waiting for their return value to be
> read out of the process table. I'd like to know myself how that can
> happen when their parents are gone...

They are reparented to init. One of init tasks is to reap all
processes who lose their parents.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
