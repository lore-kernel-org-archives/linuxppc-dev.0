From: Alan Cox <alan@cymru.net>
Message-Id: <199812281304.NAA04349@snowcrash.cymru.net>
Subject: Re: TCPv4 checksum errors
To: schwab@issan.informatik.uni-dortmund.de (Andreas Schwab)
Date: Mon, 28 Dec 1998 13:04:17 +0000 (GMT)
Cc: alan@cymru.net, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        davem@dm.cobaltmicro.com, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org, linux-m68k@lists.linux-m68k.org,
        VANDROVE@vc.cvut.cz
In-Reply-To: <vyzr9tky659.fsf@issan.cs.uni-dortmund.de> from "Andreas Schwab" at Dec 28, 98 10:20:34 am
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Alan Cox <alan@cymru.net> writes:
> 
> |> The classic bad packet error is a frame that ends up with
> |> 
> |> checksum =FFFF end around carry left =1
> 
> There can never be a carry if the sum is FFFF.  A sum of two 16 bit values
> is never be bigger than 1FFFE.

(2 previous + previous carry)

But you can show (and I sent Dave) the proof you must start in that
situation not at a sum of zero.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
