Message-ID: <39263EA0.69C60AA9@da-san.com>
Date: Sat, 20 May 2000 16:28:32 +0900
From: Seungdong Lee <sdlee@da-san.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: 8240 BogoMIPS
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan, I have successfully ported Linux to my customized 8240 board.
Linux runs fine, but I found that the performance is not as good as my
expectation.
BogoMIPS value of my board is currently 131.89.
My board is configured to run in 200MHz system clock.
Both I/D-cache are enabled. So, theoretical BogoMIPS should be around
400.
I saw that you had experience in Sandpoint-8240 board.
What was the BogoMIPS value in your case?

Thank you in advance.

-- Seungdong Lee


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
