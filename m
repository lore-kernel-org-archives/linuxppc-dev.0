Message-ID: <403F6E60.1010404@euronet.nl>
Date: Fri, 27 Feb 2004 17:20:48 +0100
From: Jos Beck II <jos_beck@euronet.nl>
MIME-Version: 1.0
To: "Hegde, Ashok" <Ashok.Hegde@fci.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to test Serial data transfer beyond 115k up to 1.5Mbps
References: <903E17B6FF22A24C96B4E28C2C0214D70146BE7E@SR-BNG-EXC01.fci.com>
In-Reply-To: <903E17B6FF22A24C96B4E28C2C0214D70146BE7E@SR-BNG-EXC01.fci.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hegde, Ashok wrote:

> I want to test my serial driver at higher speeds, How to test serial
> data transfer up to 1.5Mbps speed. Is it zmodem protocol supports this
> speed? I am able to test it (using zmodem protocol )up to 115K, beyond
> this I am facing problem.

You mentioned 115k2, probably an async port.
Do you want to run async at 1,5mbit/s?
What kind of device will that be?
I think the zmodem protocol does not mind to be used at higher rates :o)
Your problem is probably somewhere else. (drivers?)

JB

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
