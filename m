Message-ID: <3E9657D2.2030907@kegel.com>
Date: Thu, 10 Apr 2003 22:51:14 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Jikun Sun <jack.sun@bmrtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux crash when big application executing on PPC405GP board
References: <3E95E275.1050002@kegel.com> <3E9617D4.40EB5B63@bmrtech.com>
In-Reply-To: <3E9617D4.40EB5B63@bmrtech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jikun Sun wrote:
>>jack.sun@bmrtech.com wrote:
>>
>>>Board: CSB272 IBM PPC405GP
>>>Linux kernel version: 2.4.17
>>>Linux kernel can boot nfs root filesystem on the board. Shell works
>>>correctly.
>>>However the system will oops when execute big applications, such as
>>>copying a file which is larger than 2MBytes.
>>>The following is ksymoops:
>>>
>>>The size of vmlinux.srec is 2.076Mbytes.
>>>root@192.9.200.145:/# cp vmlinux.srec vmlinux.srec.bak
>>>
>>>Oops: kernel access of bad area, sig: 11
>>
>>Where did you get your kernel?
>
>
> MontaVista

Which version, Montavista Linux 2.1?
Are you using their software unmodified, or have you changed anything?
I assume this is the unsupported preview edition,
otherwise you'd be on the phone to Montavista?

>>What compiler did you use to build it?
>
>
> ppc_405-gcc

What does ppc_405-gcc --version say?
- Dan


--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
