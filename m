From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: NVRAM stuck in DST?
Date: Fri, 7 Dec 2001 22:39:51 +0100
Message-Id: <20011207213951.5313@smtp.wanadoo.fr>
In-Reply-To: <20011207213804.7802@smtp.wanadoo.fr>
References: <20011207213804.7802@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The kernel time is calculated from the RTC local time, offseted by
>the pram gmt offset & dst to get a GMT time.

Note that the offset MacOS stores there already includes DST.
The kernel doesn't use the additional DST flag, it's just displayed
in the message to help understand why your offset is wrong ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
