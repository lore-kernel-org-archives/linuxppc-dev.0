Message-ID: <394DE207.84B4153F@pop.agri.ch>
Date: Mon, 19 Jun 2000 11:04:10 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems handling large files??
References: <200006182257.AAA00912@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> Hi all,
>
> I've come across another problem in the 2.3.99 kernels (I've not had a
> chance to try 2.4.0-test). This is with 2.3.99-pre9 from Paul's rsync.
>
> Whenever a file larger than a few megabytes is created, the system will
> report 'out of memory' errors at random file syizes, while writing the
> file.
[snip]
> So the 'Cannot allocate memory' comes from the system (libc? system
> call?).
>
> Anybody know what's going on? Can you verify this on a 2.4.0-test
> kernel? FWIW, bonnie _was_ working OK on 2.2.13 (later unverified) and
> 2.3.48 (latest benchamrk I have).
>
> Clues?

As reported before, an update to 2.4.0-test1-ac19 wouldn't be a bad idea.
I tried bonnie a few minutes ago on a fsmlabs tree 2.4.0-test-ac19 which
still reports as ac18. And I had no problems so far. Bonnie ended with
giving me some ? results. I did it two times with a 100MB file on a
wallstreet. One try without hdparm tuning the other one with.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
