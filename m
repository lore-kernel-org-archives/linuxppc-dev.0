Return-Path: <pengxihan@gmail.com>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191]) by ozlabs.org (Postfix) with ESMTP id 63418B7CFF
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2010 02:53:11 +1100 (EST)
Received: by pzk29 with SMTP id 29so630127pzk.17
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 07:53:10 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 28 Jan 2010 23:53:10 +0800
Message-ID: <389deec71001280753n2df39d98m4b8c60f971a29bc7@mail.gmail.com>
Subject: Is it normal when kernel printed "xxx used greatest stack depth"
From: hank peng <pengxihan@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On my MPC8548 based board, sometimes kernel printed out the following
messages, I wonder if it indicates the system is not normal?

pdflush used greatest stack depth: 4048 bytes left
pdflush used greatest stack depth: 4028 bytes left
pdflush used greatest stack depth: 3964 bytes left
pdflush used greatest stack depth: 3916 bytes left

-- 
The simplest is not all best but the best is surely the simplest!
