Message-ID: <3CEC1E95.4CCCA5CA@esteem.com>
Date: Wed, 22 May 2002 15:41:25 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Dan Kegel <dkegel@ixiacom.com>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What problems are there with floating point emulation in the kernel?
References: <9A9C83C019F35D47A570460E87D5D8AB0125EAB9@racerx.ixiacom.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Kegel wrote:
>
> Since it's very easy to avoid the use of floating point in
> the kernel, it has not been a big issue.
>
> Do you need to use floating point in the kernel for some reason?
> - Dan

Its not the use of floating point in the kernel thats the problem.

	I would like to "emulate" the fpu in the kernel so I can
compile glibc and everything else with fpu instructions to save
ram. I have been told however that there are "issues" with this
approach, and the only way to go is to emulate the fpu in the
kernel and compile everything with soft float. What I want to
know is what these issues are? (accuracy,segment_fault,etc..)

Conn

--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
