Mime-Version: 1.0
Message-Id: <p05100304b7b1e866127d@[10.0.0.42]>
In-Reply-To: <15244.11337.823289.698210@titan.metzler>
References: <15244.11337.823289.698210@titan.metzler>
Date: Tue, 28 Aug 2001 17:39:30 -0700
To: <mocm@convergence.de>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: firewire screwup
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think you may have corrupted nonvolatile memory.  Try doing a
complete PRAM wipe: turn the computer on while holding Cmd+Opt+P+R
and let it do several reboot / PRAM wipe cycles in a row.  Five or
six is probably enough.  (The first PRAM wipe doesn't clear
everything.  The firmware watches to see if you do several in a row
and will do successively more thorough resets on each iteration.)
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
