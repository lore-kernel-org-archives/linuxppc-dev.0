Return-Path: <xenidis@gmail.com>
Received: from mail-pz0-f46.google.com (mail-pz0-f46.google.com
	[209.85.210.46]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F101BB6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 08:10:15 +1000 (EST)
Received: by pzk32 with SMTP id 32so5053812pzk.33
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 08 Aug 2011 15:10:12 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: powerpc: Get icswx to work on both Book3s and Book3e platforms
Date: Mon,  8 Aug 2011 17:26:45 -0500
Message-Id: <1312842408-21482-1-git-send-email-jimix@pobox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patches deal with the fact that Book3e parts already
have a PID register that is managed by the system.  Currently an ICSWX
not in the ACOP will get rejected as specified by both architectures.


-JX
