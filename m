From: Subodh Nijsure <subodh@best.com>
Message-Id: <200111070012.QAA23022@shell9.ba.best.com>
Subject: Compiling kernel with -g option.
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 6 Nov 2001 16:12:13 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry if this is "basic" question but I looked through mailing and couldn't
find a solution.

When I compile kernel and some of my own modules together I get tons
of error like --

relocation truncated to fit: R_PPC_REL24 copy_to_user
..
..

However if I compile everything with -O2 options everything works fine,
any way I can fix this so I can debug things....

Thanks.

/Subodh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
