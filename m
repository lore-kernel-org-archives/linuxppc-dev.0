To: Sylvain Munaut <tnt@246tnt.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL & New bestcomm code ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Mar 2004 08:34:36 +0100."
             <40458A8C.8020009@246tNt.com>
Date: Wed, 03 Mar 2004 09:03:26 +0100
Message-Id: <20040303080332.0EA92C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40458A8C.8020009@246tNt.com> you wrote:
>
> and it works just fine ... Apparently when the kernel was too big, the
> area near 100000 is probably used by u-boot in some way, maybe during

Well, it is not used by U-Boot itself, but when you have a big  Linux
kernel it starts overwriting itself when you uncompress it to address
0.

> software issue. Maybe u-boot should give some warning about that ( if
> it's the cause, not yet sure ). But that's off topic here.

U-Boot does not know the uncompressed size in advance. And  anyway  -
it's  a  pilot  error  :-)  In modification of anmother famous quote:
"U-Boot was not designed  to  stop  you  from  doing  stupid  things,
because that would also stop you from doing clever things."

> Now, I'm just looking forward for new BestComm code, to get AC97 and IDE
> DMA running ( quite slow and CPU intensive right now ... ).

:-(

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Q:  How many DEC repairman does it take to fix a flat ?
A:  Five; four to hold the car up and one to swap tires.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
