Message-ID: <3CC7CB2C.1010106@dgt-lab.com.pl>
Date: Thu, 25 Apr 2002 11:23:56 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Various DIMM-s problem on 860
Content-Type: text/plain; charset=windows-1250; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have questin on using DIMM with 860
There are no probelems with DIMM-s on 8260, but on 860 there are no
specialized BankSelect lines.
But there are plenty of DIMM types

On 860 there are some choises:
 -there are a lot of jumpers (or 0-ohm reistors)
 -use only one type of DIMM(which is not acceptable)
 -use somechip selects,and there are MEMORY HOLES in them

Q: Is  there any simpleway to use non-linear addresedmemory in linux? If
so, how to enable this in kernel?


for example there is:
0x0000_0000 .. 0x001f.ffff memory
0x0010_0000 .. 0x002f.ffff NOTHING!!!
0x0020_0000 .. 0x003f.ffff memory



--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
