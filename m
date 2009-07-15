Return-Path: <a.sudheer443@gmail.com>
Received: from mail-bw0-f207.google.com (mail-bw0-f207.google.com
	[209.85.218.207])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 4A170B7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 18:36:47 +1000 (EST)
Received: by bwz3 with SMTP id 3so3281963bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 01:36:44 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 15 Jul 2009 14:06:42 +0530
Message-ID: <4312c3250907150136y4c98c78ak1b4fe50534248442@mail.gmail.com>
Subject: ethernet driver - problem capturing own packet in promiscous mode
From: sudheer a <a.sudheer443@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636c5bb897e9872046eba741b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636c5bb897e9872046eba741b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all

In ethernet driver  i need to enable promiscous mode and have to capture the
packet that is sent by the same ethernet.

The board is connected to a packet generator and could send/receive packets
 whenever i need .

In the board ethernet driver , I made sure that am sending only broadcast
packets and promisc mode is enabled but the packets are not captured. If i
am sending a packet to the board from packetgenerator it is receiving.

Could any one please suggest me any clues.

Having the promisc enabled:
Packet sent by packetgenerator is received by board.
Packet sent by board is received by packetgenerator, The same packet should
be captured by board as promiscuous is enabled. but not happening.

Thanks
Sudheer

--001636c5bb897e9872046eba741b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi all</div>
<div>=A0</div>
<div>In ethernet driver =A0i need to enable promiscous mode and have to cap=
ture the packet that is sent by the same ethernet. </div>
<div>=A0</div>
<div>The board is connected to a packet generator and could send/receive pa=
ckets =A0whenever i need .</div>
<div>=A0</div>
<div>In the board ethernet driver , I made sure that am sending only broadc=
ast packets and promisc mode is enabled but the packets are not captured. I=
f i am sending a packet to the=A0board from=A0packetgenerator it is receivi=
ng.</div>

<div>=A0</div>
<div>Could any one please suggest me any clues.</div>
<div>=A0</div>
<div>Having the promisc enabled:</div>
<div>Packet sent by packetgenerator is received by board.</div>
<div>Packet sent by board is received by packetgenerator, The same packet s=
hould be captured by board as promiscuous is enabled. but not happening.</d=
iv>
<div>=A0</div>
<div>Thanks</div>
<div>Sudheer</div>
<div>=A0</div>
<div>=A0</div>

--001636c5bb897e9872046eba741b--
