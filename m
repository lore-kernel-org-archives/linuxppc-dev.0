To: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Queue task Problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 Apr 2002 12:47:27 +0200."
             <sccd40ff.057@mail.frequentis.com>
Date: Mon, 29 Apr 2002 12:58:21 +0200
Message-Id: <20020429105826.33CB4FF66@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <sccd40ff.057@mail.frequentis.com> you wrote:
>
> I wrote a device driver which handles the SCC in UART mode of a MPC860T
> for a simple protocol. The protocol start with a byte, the other side
> send a ack, then the packet will be sent. At last an ack will be send
> from the receiver. My problem is, that sometimes the bottom half part of
> my software won't be executed.

Ummm... is there  any  good  reason  (except  maybe  for  a  training
exercise to write a new driver for that instead of using the existing
(and working) SCC UART driver?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Doubt is a pain too lonely to know that faith is his twin brother.
- Kahlil Gibran

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
