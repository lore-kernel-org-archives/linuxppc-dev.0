Date: Tue, 23 Apr 2002 11:25:45 +0200
From: Michael Baumann <miba@peppercon.de>
Reply-To: Michael Baumann <miba@peppercon.de>
Message-ID: <7195197386.20020423112545@peppercon.de>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: 405GP i2c slave handling
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

   I am trying to get i2c slave behaviour to work (currently only
   writes to our device) but run into some problems:
   When reading/writing with two of our boards everything works
   fine, but when working with the device I actually want to address
   (an IPMI BMC on an Intel SDS2 Board) the first bytes are received
   correctly, but after this the BMC sends the message again and (the
   most strange one) before this I get my own address byte in the
   slave receive buffer, which absolutely should not happen.
   So I guess our device behaves wrong in some way while
   receiving/acknowledging the bytes. I am using the 405 IIC
   interface, not the direct control of clock/data.

   Did anyone work with i2c as slave and/or has some hints for me?


CU,
Michael

--
mailto:miba@peppercon.de
icq: 24709334


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
