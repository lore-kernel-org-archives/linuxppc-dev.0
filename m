Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A8C5F68962
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 08:13:55 +1100 (EST)
To: Theo Gjaltema <gjalt007@chello.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Dec 2005 22:48:53 +0100."
	<43B459C5.1060206@chello.nl>
Date: Fri, 30 Dec 2005 22:13:52 +0100
Sender: wd@denx.de
Message-Id: <20051230211352.D73E7352597@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: eldk bug?how to fix 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <43B459C5.1060206@chello.nl> you wrote:
>
> I've seen these messages before. They were gone when I compiled using
> ppc_8xx-gcc compiler of a different ELDK version.
> What version of ELDK are you using? Which gcc version?

This has nothing to do with ELDK versions,  or  any  other  toolchain
issues.

> >[root@localhost atmlz]# ppc_6xx-gcc -c -o temp atm_aalx.c         
> >atm_aalx.c: In function `main':                                   
> >atm_aalx.c:201: warning: return type of `main' is not `int'       
> >/tmp/cciJlehe.s: Assembler messages:                              
> >/tmp/cciJlehe.s:916: Error: unsupported relocation against r3     
...
> >         mfmsr r3                  
> >         ori r3,r3,0x8000          
> >         andi. r3,r3,0xffbf        
> >         mtmsr r3                  

It's a user only problem (using symbolic names like  "r3"  in  inline
assember  statements  without  incuding  the  proper  header files to
resolve thise names).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We fight only when there is no other choice. We prefer  the  ways  of
peaceful contact.
	-- Kirk, "Spectre of the Gun", stardate 4385.3
