Date: 16 Nov 2002 01:36:34 -0000
Message-ID: <20021116013634.22387.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
From: "sanjay k k" <fren00@rediffmail.com>
Reply-To: "sanjay k k" <fren00@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: where to put delay between address and data on I2C + 440
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I need to put insert some delay between address and data byte.
Where should i do this in kernel for PPC 440.

I need to do the following:
start~address [delayof 110 micro sec.]data~stop.

Can any body tell me where to put this delay?

Thankx
Sanjay

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
