Message-ID: <39CB9AB8.27CBD412@mvista.com>
Date: Fri, 22 Sep 2000 10:45:28 -0700
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Pawel Zawora <pzawora@fideltronik.com>
CC: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: illegal intruction
References: <39CB0FDD.2E5C8DF7@fideltronik.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We need a lot more information to understand what the problem might be.

I see it's Linux PPC, kernel version 2.2.13... but what CPU, what board,
how much ram, etc.

>From not knowing anything about this, it sounds like you are trying to
run software that is using floating point on a system that doesn't
have an FPU.  But that is just a guess.

--Mark

Pawel Zawora wrote:
>
> I'm working with Linux PPC, kernel version 2.2.13 with nfs as a root
> file  system. When I try to run any software sometimes a exeption
> undefined instruction code 0xffffffda occurs (kernel try it emulate),
> sometimes everything works.
> Does anybody know what can be a reason of  behavior like this?
> It isn't a problem of limited RAM memory space.
> What is  the best way to find this error?
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
