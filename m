Message-ID: <39043B16.3F546067@ucdavis.edu>
Date: Mon, 24 Apr 2000 05:16:22 -0700
From: Wilson Taylor Holliday <wtholliday@ucdavis.edu>
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>
CC: LinuxPPC dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Trouble w/yaboot
References: <200004240637.XAA05529@pop3.ucdavis.edu> <20000423235243.L16721@plato.localdomain.local>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

Thanks Ethan for the very prompt response :-). Sorry about my ambiguity
regarding where I was using the device alias. I was referring to the yaboot.conf
file rather than my inital OF command to get to yaboot. Anyway, I solved the
problem, I renamed vmlinux.2.2.15pre3 to vmlinux and then hd:9,vmlinux worked
fine.

my next task is to get XFree 4.0 working on both my monitors (seems tough)

thanks
- Taylor


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
