Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <000001c41b9e$8ca8c530$d100000a@sbs2003.local>
References: <bf46dbbf4188.bf4188bf46db@jhumail.jhu.edu> <000001c41b9e$8ca8c530$d100000a@sbs2003.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6AC6540F-88A3-11D8-8C20-000A95DC1AB2@macdiscussion.com>
From: Mark Guertin <mguertin@macdiscussion.com>
Subject: Re: 4way smp on ppc32
Date: Wed, 7 Apr 2004 10:54:05 -0400
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 6-Apr-04, at 2:15 AM, Benjamin Herrenschmidt wrote:

>
>> I'm mostly cross-compiling the kernels with gcc 3.3.2.  The userland
>> is an old Debian, but I'll upgrade that as soon as I get a kernel
>> booting.
>>
>> Do you have recommendations of gcc/kernel combos that should work?
>> I'm also starting to wonder if my h/w is bad (it did come from eBay.
>> . .)
>
> Could well be bad RAM or bad cache
>
> Ben.
>

I was going to mention the same thing, to run some hardware testing if
you could.  The only time I've seen any real ICE problems was with gcc
3.1.x and projects that weren't really adjusted for gcc 3.x yet, other
than that things have been fine for my setup.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
