Date: Fri, 9 Jul 2004 13:18:02 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: what's the value of CONFIG_8xx_UART?
In-Reply-To: <20040709160919.GD28002@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0407091316110.3143@localhost.localdomain>
References: <Pine.LNX.4.60.0407081800340.1772@localhost.localdomain>
 <20040709160919.GD28002@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 9 Jul 2004, Tom Rini wrote:

> On Thu, Jul 08, 2004 at 06:04:31PM -0400, Robert P. J. Day wrote:
>
>>
>>   under MPC8xx CPM Options, what's the purpose of selecting
>>
>>   [ ] Use UART         (representing option CONFIG_8xx_UART)
>
> This is the older serial driver.  This can probably go away soon (Kumar
> and Panto have fixed the issues wrt needing SMC1 and SCC1, should be in
> kernel.org soon).

cool.  so now i can go find something else to complain about. :-)

rday

p.s.  when you say "should be in kernel.org soon", what's the flow of
fixes between that and the linuxppc-2.5 tree at bkbits?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
