Date: Thu, 18 Mar 1999 17:55:15 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SCSI crashes with vger
In-Reply-To: <19990318183101.012814@mail.mipsys.com>
Message-ID: <Pine.LNX.4.05.9903181753000.8817-100000@p05-10.hartford.dialin.ntplx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Mar 1999, Benjamin Herrenschmidt wrote:

> Both latest vger (2.2.4) and latest paul's kenrel (2.2.2) crash in the
> NCR53C8XX driverm in ncr_wakeup_done, just after having probed SCSI
> controllers (the NCR and MESH) and before (or when) probing devices.

Erg <paranoid worry>. In 2.2.2 there was a "scsi fix" which seems to have
fixed the problem that some people (myself, Dan J) had when trying to do
things like burn a CD on the ext chain or use both chains at once.  Now
it's working well enough for me to do a silly thing like a raid0 /usr :)
Hope this isn't related.. </paranoid worry>

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
