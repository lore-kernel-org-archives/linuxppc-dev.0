Date: 5 Sep 2002 13:48:53 -0000
Message-ID: <20020905134853.32298.qmail@webmail9.rediffmail.com>
MIME-Version: 1.0
From: "Narendra  " <narengh@rediffmail.com>
Reply-To: "Narendra  " <narengh@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Unable to do I/O operations with WLAN card. 
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I have Two EP RPX-LITE board.

I have my WLAN driver working fine on one EP board.

But I have problems with the other board. INITIALIZE command to
D-Link card is successful but after that issueing ACCESS command
is failing if i try to write any record, with Status Register
having value 0x7b21 and RESP0 having the value 4.

Any Idea What could be the problem??
Is there any problem with the Target Board?..because same card,
same driver is working fine with other EP board.

I am using HARD HAT Linux 2.0.

Thanks in advance,
Naren


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
