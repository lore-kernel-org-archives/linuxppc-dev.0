Date: Mon, 29 Mar 1999 18:18:40 -0700
From: Cort Dougan <cort@ppc.kernel.org>
To: Tom Rini <tmrini@ntplx.net>
Cc: cort@ppc.kernel.org, Piotr Muszynski <u0295020@iwate-u.ac.jp>,
        linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: vger 2.2.5 kernel breaks (on scsi?)
Message-ID: <19990329181840.A4591@persephone.ppc.kernel.org>
References: <36FF53A7.5FB500AC@iwate-u.ac.jp> <Pine.LNX.4.10.9903291740220.16395-100000@p07-42.hartford.dialin.ntplx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9903291740220.16395-100000@p07-42.hartford.dialin.ntplx.com>; from Tom Rini on Mon, Mar 29, 1999 at 06:59:34PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Damn.  I'll track it down and revert the necessary change.  I get this
error on some machines and not others.

} I'm getting this as well on my 7500 (CONFIG_PMAC, not CONFIG_ALL_PPC).
} The problem seems to stem from the "smarter ioremap" as reverting
} arch/ppc/mm/init.c to 1.152 allows me to boot again.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
