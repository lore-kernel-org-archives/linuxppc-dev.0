Message-ID: <006e01c38dae$c4df2490$0202a8c0@homevl9biy3v7e>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: ES1371 on Walnut Platform
Date: Wed, 8 Oct 2003 23:13:45 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

    I tried to bring up a ES1371 audio card on Walnut evaluation board. It
is recognized successfully and the content of registers are dumped and find
to be the same as that found on PC. But it doesn't work because I can't
receive any interrupt from the card to show the completion of DMA transfer.

    Up to this point, I have no idea how to continue. Now, I can only trace
about the PCI related code to see if it is the cause. Does anyone have the
same or similar problem met before? Any suggestions are welcome.

    Thanks.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
