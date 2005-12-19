Return-Path: <andrey.warkentin@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.203])
	by ozlabs.org (Postfix) with ESMTP id 768EC6889F
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Dec 2005 18:11:14 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id q3so1111874nzb
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Dec 2005 23:11:12 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C8F35FC5-C2AC-496B-8062-DAD683ADBBC1@gmail.com>
From: Andrei Warkentin <andrey.warkentin@gmail.com>
Date: Mon, 19 Dec 2005 01:11:08 -0600
To: linuxppc-dev@ozlabs.org
Subject: Mac OpenFirmware 3.x questions.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I was just wondering if I clearly understand the process of using the  
client interface if I ever (in my kernel) decide to set up my own  
virtual memory (or for that matter pretty much do anything that  
involves modifying CPU state) -
1) Load saved OF-era SDR1, MSR, SPRGs, BATs, segment registers, SRR0,  
SRR1,  restore OF exception vectors.
2) Flush i/d caches.
3) Call client interface.
4) Load kernel SDR1, MSR, SPRGs, BATs, segment registers, SRR0, SRR1,  
restore kernel exception vectors.
5) Flush i/d caches.

Does this seem reasonable? Do I need to save/restore anything else? I  
understand that OF (3.x) lives in flash ROM, and only copies the  
exception vectors from 0xfff----- down to 0x000----- - but where does  
it store the page tables (as used by claim/release) and where is OF  
physically/virtually? It would be pretty bad to wipe out OF's .bss or  
whatever, or even worse... overwrite the flash itself.  :)

Thanks and have a great day.

Andrei Warkentin
andrey.warkentin@gmail.com
Cell: (+1) (847) 321-15-55
Office: (+1) (312) 756-15-00 x614
