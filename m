Message-ID: <004001c14bf3$7c326c60$b480a984@int.serialsystem.com.sg>
From: "Nguyen Trung Thanh" <jaringuyentrungthanh@yahoo.com>
To: "'Linuxppc-Embedded '" <linuxppc-embedded@lists.linuxppc.org>
References: <619D608DD3F0D311882C009027732E1A8B1779@ntserver.act.domain>
Subject: USB Isochronous for MPC823
Date: Wed, 3 Oct 2001 18:09:08 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I've tried to use m8xxhci.c from Hardhat2.0,
but I saw that it still has a bunch of errors.

I did make many changes, and it could run with control msg, and bulk msg.
However, it's not fully reliable, of course because I'm still testing it.

Now, I am stuck with Isochronous msg.
Have you done it before? Or do you have any information that I need to pay
attention to?

I read in the spec of MPC823, it just said that I'd take care of TM bit in
USEP, (transfer mode for endpoint 0).
Then I modifed that code, to change this TM bit according to BULK, ISO or
CONTROL msg.

Pls help me to make the usb audio driver run on MPC823.
I'll try to make it reliable.
Thanks,
Jari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
