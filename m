Return-Path: <mgroeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 1EAB72BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 18:45:31 +1000 (EST)
Date: Thu, 14 Oct 2004 10:25:31 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
Sender: mag@sysgo.com
To: Sam Song <samlinuxppc@yahoo.com.cn>
In-Reply-To: <20041013193959.57540.qmail@web15605.mail.cnb.yahoo.com>
Message-ID: <Pine.LNX.4.61.0410140952570.1661@mag.sysgo.com>
References: <20041013193959.57540.qmail@web15605.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Meaning of BSP and LSP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 14 Oct 2004, Sam Song wrote:

> I'd like to make sure about the meaning of BSP and
> LSP. There is sth unclear in my mind, I am afraid.

>From what I know, the term BSP was coined as an acronym for "Board 
Support Package" in pre-Linux days. To me it is most familiar in 
conjunction with Embdedded (RT)OSes such as LynxOS, vxWorks, or pSOS 
and many others. These systems have a more or less clearly defined BSP 
API, meaning that a port to a new platform is a well defined process.

Grossly simplified, the BSP provider must implement a number of 
support functions which make hardware resources (interrupts, memory 
and so forth) available to the common kernel code. Note also that this 
is valid across architectures (PPC, ARM, X86...).

Linux still doesn't really offer something like this. Some people may 
argue that things are actually improving, but most people probably 
just don't care. The simplest reason I can think of for that is that 
there were always enough knowledgable people to do the hard porting 
work. Also, obviously, Linux doesn't care for commercial issues such 
like wanting to keep the common kernel code closed.

"LSP" is a term introduced by MontaVista, AFAIR, so maybe one of the 
MV folks on this list wants to elaborate on this?

Bottom line: BSP is an OS/Vendor specific term to capture the software 
components related to a specific board. It is a useful handle in 
project discussions, provided that all participants use the same 
notion.

Regards,
Marius

-- 
Marius Groeger <mgroeger@sysgo.com>
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
