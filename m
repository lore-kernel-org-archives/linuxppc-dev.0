MIME-Version: 1.0
Message-Id: <39002421.07687@mta1>
Date: Fri, 21 Apr 2000 17:49:21 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: memory map
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,everyone.
I have some questions about the memory map on linux on 8xx and ppc
1)Some area eg BCSR mapped below KERNELBASE,is this safe?
I check some process's vm area,it does not fall in this area,will
it be unsafe under some circumstances?
2)I read mapin_ram() in mm/init.c ,found that phys mem is also mapped
both by bat and page table ,what is this for?
Can someone help me?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
