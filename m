Date: Fri, 9 Jul 2004 09:09:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: what's the value of CONFIG_8xx_UART?
Message-ID: <20040709160919.GD28002@smtp.west.cox.net>
References: <Pine.LNX.4.60.0407081800340.1772@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0407081800340.1772@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 08, 2004 at 06:04:31PM -0400, Robert P. J. Day wrote:

>
>   under MPC8xx CPM Options, what's the purpose of selecting
>
>   [ ] Use UART         (representing option CONFIG_8xx_UART)

This is the older serial driver.  This can probably go away soon (Kumar
and Panto have fixed the issues wrt needing SMC1 and SCC1, should be in
kernel.org soon).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
