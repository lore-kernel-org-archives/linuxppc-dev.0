To: ian reinhart geiser <geiseri@msoe.edu>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-users@lists.linuxppc.org
Subject: Re: MOL on the Pimiso PB ROCKS... sorta.
References: <Pine.OSF.3.96.1000912124529.6222A-100000@torres.msoe.edu>
Content-Type: text/plain; charset=US-ASCII
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 13 Sep 2000 10:02:05 +0200
In-Reply-To: ian reinhart geiser's message of "Tue, 12 Sep 2000 12:47:03 -0500 (CDT)"
Message-ID: <87g0n4wwhu.fsf@hades.nocrew.org>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ian reinhart geiser <geiseri@msoe.edu> writes:

> Well i just got MOL on my Powerbook,  It runs pretty well
> fast in all BUT for some reason i cannot get my mouse to
> work.
>
> i have it set to /dev/adbmouse and adb as the protocal.
>
> i am also running the new 2.2.17 kernel from pauls.
>
> has anyone else seen this?

Yes, I've seen this, and according to Samuel, it's a VBL problem,
which is fixed in the bitkeeper archive, but I haven't tested that
version yet.

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
