Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1E6AEDDE0C
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 00:54:57 +1000 (EST)
Message-ID: <46ADFC36.5060709@ru.mvista.com>
Date: Mon, 30 Jul 2007 18:56:54 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Subject: Re: [patch][0/5] powerpc V2 : Add support to fully comply
	with	IEEE-754 standard
References: <32F3CC26D4DAC44E8ECD07155727A46E8B7F7F@zch01exm20.fsl.freescale.net>
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8B7F7F@zch01exm20.fsl.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Zhu Ebony-r57400 wrote:

>>>>>>Did you end up getting testfloat running?  I'd like to see some 
>>>>>>testing results before accepting these patches.  I think estfloat is
>>>>>>our best bet at this point.

>>>>>Hi Kumar,

>>>>>I looked into the testfloat suit, and found all the instructions it 
>>>>>tests (more than 50)should be implemented based on ASM.

>>>>Don't follow?  Can't you build it with the e500 compiler?

>>>The TestFloat suite provided the target of 386-Win32-gcc and 
>>>SPARC-Solaris-gcc only, and a template for user to porting his own 
>>>processor. Some general instructions are implemented in C, but some 
>>>CPU specific instructions like evfsmul need to be implemented 
>>>assemblely. To build it with e500 compiler we still Have some porting 
>>>work to do.

>>I wouldn't worry too much about the vector forms.  If the 
>>scalar single fp and double fp test out ok the vectors are 
>>pretty much similar enough.

>>Lets just get the scalar versions tested and work out any 
>>issues there.

> OK, I will focus on scalar SFPF and DPFP versions first.

    Any progress with this patchset?

WBR, Sergei
