In-Reply-To: <a85093a81050.a81050a85093@jhumail.jhu.edu>
References: <a85093a81050.a81050a85093@jhumail.jhu.edu>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B8337AE4-8749-11D8-9563-000A95DC1AB2@macdiscussion.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Mark Guertin <mguertin@macdiscussion.com>
Subject: Re: 4way smp on ppc32
Date: Mon, 5 Apr 2004 17:39:30 -0400
To: ERIC NORTHUP <eric.northup@jhu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've not had any of those problems with my machine, it runs very solid
and I've in fact compiled a _lot_ of code on it, including hundreds
(maybe thousands) of kernel builds for ppckernel.org .. it was the main
build machine for over a year.  It also did a lot of rebuilding for
testing of various packages when I was doing Gentoo PPC work.

What distro are you using?  What versions of GCC, etc?

Mark

On 3-Apr-04, at 7:59 PM, ERIC NORTHUP wrote:

> On Wednesday, March 31, 2004 12:56 pm, Mark Guertin wrote:
>> I'll try and find some time to test this stuff on my daystar quad
>> as
>> well.  I know that right up to latest 2.4.x all 4 of my CPU's are
>> still
>> working fine.
>
> OK, I have just gotten a 2.4 smp kernel booted, and it does find all 4
> cpus.  However, the machine is far from stable.  GCC dies on a fatal
> signal or reports an "internal compiler error", but when re-inovked on
> the same file it works.  Other times, it takes the ssh connection down
> with it.  I was trying to build LTP or some other code to narrow down
> the problem areas, but gcc is too flaky for this to work.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
