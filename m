In-Reply-To: <01139FC052A0D411900B00508B9535FC0F0D2864@ZCH07EXM04.corp.mot.com>
References: <01139FC052A0D411900B00508B9535FC0F0D2864@ZCH07EXM04.corp.mot.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BDE32191-ECF1-11D8-9848-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: JTAG debug mechanism
Date: Fri, 13 Aug 2004 02:26:42 -0400
To: Li Yang-r58472 <LeoLi@freescale.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 13, 2004, at 1:44 AM, Li Yang-r58472 wrote:

> .... But my question is how it can read/write the core registers and
> system memory as implemented by most JTAG emulators.

By using the Freescale COP implementation over the JTAG pins.
All debuggers do this.  Most of us don't care about such details,
we just buy the tools, plug them in and use them.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
