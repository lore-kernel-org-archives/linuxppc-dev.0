To: Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc trees / BK help
References: <40168C3E.7010903@g-house.de>
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 27 Jan 2004 17:23:46 +0100
In-Reply-To: <40168C3E.7010903@g-house.de> (Christian Kujau's message of
 "Tue, 27 Jan 2004 17:05:18 +0100")
Message-ID: <jewu7d2wdp.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christian Kujau <evil@g-house.de> writes:

> after passing the consistency check, a sourcetree shows up  but
> filenames are different from normal:
>
> evil@sheep:/data/MP3/scratch/kernel$ ls linuxppc-2.5-benh-BK/
> BitKeeper  Documentation  SCCS  arch  crypto  drivers  fs  include  init
> ~ ipc  kernel  lib  mm  net  scripts  security  sound  usr
> evil@sheep:/data/MP3/scratch/kernel$
>
> - --> there are no files in the directory, only dirs.

$ bk -r get

Andreas.

--
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
