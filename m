In-Reply-To: <BCEFJBPJCGFCNMMMIDBHGEBICGAA.Joakim.Tjernlund@lumentis.se>
References: <BCEFJBPJCGFCNMMMIDBHGEBICGAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2EBE5450-A9B4-11D8-BBC2-003065F9B7DC@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Serial port text corruption
Date: Wed, 19 May 2004 12:47:15 -0400
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 19, 2004, at 11:49 AM, Joakim Tjernlund wrote:

> After some research and testing, I have found that agetty enables
> parity checking....

Interesting.

> I don't think that such a character was entered in my case, but
> perhaps a
> random character was generated when connecting the cable?

Well, you are running 115200, what happens if you use some reasonable
baud rate like 38400 or less?

> Any ideas for a replacement getty?

I use mgetty.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
