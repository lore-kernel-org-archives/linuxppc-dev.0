Date: Tue, 26 Jan 1999 21:42:04 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Ira Joseph Woodhead <ira@wrath.iatlas.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5 deficiencies
In-Reply-To: <199901262207.RAA06012@wrath.iatlas.com>
Message-ID: <Pine.LNX.4.05.9901262141300.964-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Jan 1999, Ira Joseph Woodhead wrote:

> What is the reasoning behind including a findutils in pre-R5 that has no
> updatedb binary?? It even has scripts that use updatedb (cron jobs) but
> no updatedb binary. Furthermore, 'rpm -qlp *.rpm' reveals that it is not
> included in any package.

It's part of the slocate package.  See /etc/cron.daily/slocate.cron on how
to update the db.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
