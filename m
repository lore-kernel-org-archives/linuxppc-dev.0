Message-ID: <004201c44ee6$0acb3270$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
	"Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.58.0406091911340.3310@localhost.localdomain>
Subject: Re: trying to debug my failure to start "init"
Date: Thu, 10 Jun 2004 08:25:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>   for more feedback, i added a printk() call to the run_init_process()
> function in init/main.c to see what it thought it was doing.

Maybe you should add a printout of errno, which the execve() inside of
run_init_process() will set - might give an important clue.

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
