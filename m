Message-ID: <011201c38bdc$bdf96510$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Walnut boot problem solved
Date: Mon, 6 Oct 2003 15:37:48 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

    I have figured out why my kernel hanged while booting on Walnut
platform. It is because the structure of board_info is different between
u-boot-0.4.8 and linuxppc-2.4-devel. After syncing the structure, I can boot
up to where the kernel tries to mount the filesystem. Attached is a patch
for the fix.

    Thanks for all help and suggestions.

Best regards,
Jacky Lam


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
