Subject: Re: TLB SETTING in 440GP
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Aman <aman@mistralsoftware.com>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <005901c288bc$3ed80990$370da8c0@aman>
References: <005901c288bc$3ed80990$370da8c0@aman>
Content-Type: text/plain
Date: 11 Nov 2002 14:20:29 +0100
Message-Id: <1037020830.22840.79.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 2002-11-10 at 14:22, Aman wrote:
>
> Hi All
>
> Can anybody tell me how the TLB setting is done in PPC 440GP linux. I did a
> comparison of TLB mapping between  eval kit and my proprietary board. There
> is a huge difference between the both.

I'm not sure what you are doing but unless the 440 code locks some tlb
entries to be static they should all change to what the system needs in
that instant. Generally TLB is a dynamic thing that should not be the
same so it's not an indication of a problem.

The contents is loaded by the kernel so you should not have to do that.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
