Message-ID: <005201c059b0$2cdef7e0$ef0fa8c0@hoangmobile>
From: "Nguyen Xuan Hoang" <jerry.nguyen@serialsystem.com.sg>
To: <support@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <DKEFKEENEHPHKNLLKHCGGEEICDAA.support@mvista.com>
Subject: PCMCIA Card Service
Date: Tue, 28 Nov 2000 18:57:56 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to get the PCMCIA CardService  running on an mpc823 board
(RPX Lite). I pick up the code from Jo-Ellen Mathews of AbsoluteValue
Systems,and I can do something like remap memory, read data from IO
port...But end up with IRQ probe fail (I start with PCMCIA Flash Card).  I
did an investigating and find out the reason, that is PCMCIA card service
already occupy the PCMCIA interrupt and I can not use request_8xxirq to
register another handler .

I am thinking that I may have to rewrite request_8xxirq and pcmcia interrupt
handler to solve this case. Is there any better solution? Have any one have
done it? I am very appreciated for any help.

Thank in advances
Hoang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
