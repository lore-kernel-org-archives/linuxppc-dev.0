Message-ID: <3CF6AF4C.1070302@mvista.com>
Date: Thu, 30 May 2002 16:01:32 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Dan Malek <dan@embeddededge.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMBench and CONFIG_PIN_TLB
References: <20020529030838.GZ16537@zax>	<3CF4E842.3070207@embeddededge.com>	<15605.24191.948013.249297@argo.ozlabs.ibm.com>	<3CF581BE.8020207@embeddededge.com>	<3CF64E9C.60303@mvista.com> <15606.47823.449239.651529@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

>>btw, there are bugs with it.  Starting several processes with init or
>>even telnetd will expose the bug.
>>
>
>David and I haven't been able to reproduce this on the Walnut or the
>EP405.  What sort of machine are you using, what processor, how much
>RAM, and what distro are you using?
>
>Paul.
>

I run MVL (of course) on a walnut with 32MB of RAM.  What is your
environment?  btw, MVL uses soft-float in glibc not floating point
emulation in the kernel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
