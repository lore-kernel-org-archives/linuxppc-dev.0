In-Reply-To: <Pine.LNX.4.05.9903181753000.8817-100000@p05-10.hartford.dialin.ntplx.com>
Date: Fri, 19 Mar 1999 00:07:56 +0100
To: Tom Rini <tmrini@ntplx.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: SCSI crashes with vger
Message-Id: <19990319000756.005553@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 18, 1999, Tom Rini <tmrini@ntplx.net> wrote:

>Erg <paranoid worry>. In 2.2.2 there was a "scsi fix" which seems to have
>fixed the problem that some people (myself, Dan J) had when trying to do
>things like burn a CD on the ext chain or use both chains at once.  Now
>it's working well enough for me to do a silly thing like a raid0 /usr :)
>Hope this isn't related.. </paranoid worry>

Do you still have the patch around so that i can revert it and see what
happen ? I'm really not familiar enough with linux to track this none. I
tried, but got deep inside the scsi subsystem, looks like it's crashing
when completing the request with a program check exception (which can
mean a lot of things, I still have to find out how to display SRR1 from xmon).

The first 2.2.2 I got from paul's rsync crashed when probing my disk on
the MESH bus (NCR bus passed fine) and worked whith this external disk
shut down. I re-rsynced some time later with Paul and now, NCR crashes
too, as does vger.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
