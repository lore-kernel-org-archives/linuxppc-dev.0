Return-Path: <lee.nipper@gmail.com>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221]) by ozlabs.org (Postfix) with ESMTP id 47D1EB6EF0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 02:37:38 +1100 (EST)
Received: by ewy21 with SMTP id 21so908829ewy.22
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 07:37:36 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 21 Dec 2009 09:37:36 -0600
Message-ID: <eabe9a7b0912210737l7cace1acka2220755566bdbfc@mail.gmail.com>
Subject: AMCC 405EX Rev D PVR
From: Lee Nipper <lee.nipper@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: lee.nipper@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have observed an odd behavior in the latest 405EX revision parts (Rev D).

Upon first power up on our custom board,
the 405EX Rev D shows a value of 0x12911470 in the PVR register.

After a reset, the 405EX Rev D shows the correct value of 0x12911475
in the PVR register.

The 405EX Rev C part had a steady 0x1291147F on first power up on the
same board.

Has anyone seen this ?

Is a wider reset pulse is required for the Rev D 405EX ?

Thanks for any feedback,

Lee
