In-Reply-To: <36EE719D.EF7C5C6D@phx.mcd.mot.com>
Date: Tue, 16 Mar 1999 20:23:14 +0100
To: Johnnie Peters <jpeters@phx.mcd.mot.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: new bootloader
Message-Id: <19990316202314.027662@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 16, 1999, Johnnie Peters <jpeters@phx.mcd.mot.com> wrote:

>I have it running.  I had some troubles with 2.2.2.  The SCSI system tended
>to lock up after awhile but this seems to be gone on 2.2.3.  The only thing
>I have so far noticed is that when compiled with SMP enabled, the 2.2.2
>release hung during semaphore handling in the SCSI driver and in 2.2.3 it
>panics at the same place.  I traced it down that far but have not had
the time
>to
>go further.

2.2.2 (from samba, I'm only getting back vger now) gave me MESH scsi
panics on boot here. (I haven't seen them for a while). the NCR 53X8XX
behaved fine but MESH panicked just after seeing my external HD. No
problem without the disk of course.

Didn't have time to try to find the problem yet neither.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
