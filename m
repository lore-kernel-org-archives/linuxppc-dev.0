Message-ID: <20020607005111.73947.qmail@web11103.mail.yahoo.com>
Date: Thu, 6 Jun 2002 17:51:11 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: Sungem bug or something else?
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020606194518.27675@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The problem was triggered by upgrading to
initscripts-6.76. The new ifup script calls the
network-scripts function check_link_down, which in
turn calls 'ip link set up eth0', then mii-tools.
Apparently at boot time the phy is not powered,
causing the oops.
Work-around: remove the link check in ifup
-roger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
