Date: Tue, 26 Jan 1999 16:26:46 -0800 (PST)
From: Matt McLean <keys@yikes.com>
To: Ira Joseph Woodhead <ira@wrath.iatlas.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5 deficiencies
In-Reply-To: <199901262207.RAA06012@wrath.iatlas.com>
Message-ID: <Pine.BSF.4.01.9901261618270.18799-100000@brio.yikes.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Jan 1999, Ira Joseph Woodhead wrote:

> What is the reasoning behind including a findutils in pre-R5 that has no
> updatedb binary?? It even has scripts that use updatedb (cron jobs) but
> no updatedb binary. Furthermore, 'rpm -qlp *.rpm' reveals that it is not
> included in any package.

<snip>

This was a decision made by redhat.  According to a note from Erik Troan
in the spec file, you're supposed to use Secure Locate (slocate) instead.
As for why a cron script that uses updatedb is still included, I don't
know. :-)

m.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
