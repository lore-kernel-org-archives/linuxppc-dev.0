Mime-Version: 1.0
Message-Id: <p05101401b895b9cbee49@[10.0.0.42]>
In-Reply-To: <453D45A8-2339-11D6-B84B-0003938E434C@ivey.uwo.ca>
References: <453D45A8-2339-11D6-B84B-0003938E434C@ivey.uwo.ca>
Date: Sun, 17 Feb 2002 12:16:16 -0800
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: question on best way to install other ide drives?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:59 PM -0500 2/16/02, Kevin B. Hendricks wrote:
>Hi,
>
>My dual 1 Gig machine has room to easily mount a second (slave) ide
>drive.  I also have an Sonnet ATA-100 pci card and another IDE drive.
>
>I would like to add both.  The Sonnet card can support up to 4 IDE
>drives.
>
>Would it be better (performancewize) to:
>
>A.  Hook both drives up the the ATA-100 pci card using two ribbon cables
>with both being masters?

(A).  IDE does not do a terribly good job of sharing bus bandwidth
between two active devices, so the ideal case for performance is one
IDE bus per device.

That said, you'll never be impacted if your workload never attempts
to exercise both the slave and master at the same time.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
