Message-ID: <3E1705CD.2090506@tataelxsi.co.in>
Date: Sat, 04 Jan 2003 21:33:25 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: mcc in mpc8260.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We are using mcp8260 interfaced with an octal E1/T1 framer (XRT84L38).
We are using 7 E1/T1 lines as input for the MCC is from the framer.

How does the MCC HDLC controller treat the incoming E1/T1 frames? will
the HDLC controller will treat each E1 line as 32 different logical
channels and interrupt when one HDLC frame (per logical channel) is
received? If it is not so, how can I get the HDLC frames? Will it fill
in one TDM channel (first in each group 0,32,64,96..etc) ?

I went through the example code given in the motorola website. But they
do not really address this problem.

Thanks and regards,
Om


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
