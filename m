Date: Mon, 31 Jul 2000 11:22:03 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Crusman <Lionel.TAILLURAT@wanadoo.fr>
cc: Lionel TAILLURAT <Lionel.TAILLURAT@ecrin.com>,
        ppc_mailing_list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: -= MVME 2300 boot args=-
In-Reply-To: <000a01bff9b0$fab528c0$4c388aa4@crusman>
Message-ID: <Pine.HPX.4.10.10007311118140.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 30 Jul 2000, Crusman wrote:

> Hi,
>
> I resolve the problem with the following Haddrive map :
>
> sda2:  Prep boot partition starting at the first sector of the harddrive.
> sda1:  root partition.
> sda3:  swap partition.

Fine, mine is root on sda1, swap on sda2 and prepboot on sda3 at the end
of the disk with an extented partition between sda2 and sda3.

> and all work well.

Yes, this does not mean that we should not trry to improve it. I just
booted 2.4.0-test5 this morning. I hope to make patches available soon,
especially for timing which is horrendous in the official kernel right
now (in several weeks now, I've never seen one of my machines locked on
the NTP server be off by more than 20 microseconds, versus tens of
milliseconds in the stock kernel).

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
