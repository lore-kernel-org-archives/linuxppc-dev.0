In-Reply-To: <19990109181915.002685>
Date: Sat, 9 Jan 1999 18:55:25 +0100
To: Paul Mackerras <paulus@cs.anu.edu.au>, linuxppc-dev@lists.linuxppc.org,
        cort@persephone.cs.nmt.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Interesting stuffs & feature bits
Message-Id: <19990109185525.022654@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 9, 1999, Benjamin Herrenschmidt <bh40@calva.net> wrote:

>Apparently, on mt heathrow-based PowerBook, channel A is 0x4000 and channel B
>is 0x8000 but MacOS always enable bit at 0x2000 when setting one of those.
>So, in the array of feature, the mask for channel A should be 0x00004200 and
>for channel B, it should be 0x00008200. So I guess this bit is wrong too. The
>result for heathrow would be:
>
>#define HEATHROW_SCCA_IO		0x4000
>#define HEATHROW _SCCB_IO		0x8000
>#define HEATHROW _SCC_ENABLE		0x2000
                               ^^^^^^
This is a typo, the value is 0x200, like OHare.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
