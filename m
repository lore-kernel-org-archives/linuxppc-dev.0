Date: Wed, 17 Dec 2003 17:27:04 -0600 (CST)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: "David C. Chiu" <dchiu@ariodata.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gcc version 2.95.3 20010315 (release/MontaVista) cross compiler
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F775A6F@orion.ariodata.com>
Message-ID: <Pine.LNX.4.44.0312171724500.24956-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 17 Dec 2003, David C. Chiu wrote:
>
> We're experiencing some unexpected behavior with binary generated with
> the said version of gcc; namely that variables declared to char appear
> to be defaulting to unsigned char.

[ snip ]

> Can someone shed some light on this? (As in, is this "normal" and we do
> not know only because we've been living under a rock ;-)

It is allowable by the specification. C89 allowed char to be either
signed or unsigned, it was up to the implementation to decide which.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
