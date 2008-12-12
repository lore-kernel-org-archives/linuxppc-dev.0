Return-Path: <js084@bucknell.edu>
Received: from ivory.bucknell.edu (ivory.bucknell.edu [134.82.9.79])
	by ozlabs.org (Postfix) with ESMTP id ED73CDE050
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Dec 2008 14:36:04 +1100 (EST)
Received: from [134.82.109.42] (js084.resnet.bucknell.edu [134.82.109.42])
	(authenticated bits=0)
	by ivory.bucknell.edu (8.14.3/8.14.3) with ESMTP id mBC2OHc9030859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Dec 2008 21:24:18 -0500
Message-ID: <4941CB50.6060704@bucknell.edu>
Date: Thu, 11 Dec 2008 21:24:16 -0500
From: Juliana Su <js084@bucknell.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: XUPV2P + EDK 9.1 + Linux 2.4
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm relatively new to the XUPV2P. Up until about a month ago, I had been 
working with an ML310. Anyway, I noticed the “XUPV2P update to kernel 
2.6 fails” thread and saw that quite a few people have been successful 
with the XUPV2P; I was hoping that those of you who have been successful 
with the XUPV2P could help me out.

First some background...

I am using EDK 9.1, EDK 10.1, the MontaVista Linux 2.4 kernel 
(linuxppc_2_4_devel), and a 256 MB DDR DIMM. I was able to get a basic 
system (XPS UART16550, DDR SDRAM - MPMC, XPS SYSACE, Linux 2.4) made in 
EDK 10.1 to work. However, I have not had any success getting a similar 
system (UART16550, DDR_SDRAM_32Mx64 - PLB DDR, OPB SYSACE, Linux 2.4) 
built in EDK 9.1 to work. The issue is that, when I turn on the board, 
nothing shows up in minicom. I checked the contents of the log_buf; it 
was filled with junk.

My goal is a system with SysACE support, Ethernet, and the AC-97 audio 
CODEC that can mount a hard drive. It seems like it would be easier to 
create this system using EDK 9.1 than EDK 10.1. Right now, though, just 
getting a basic system to work using EDK 9.1 would be great.

For those of you who have been successful with the XUPV2P, what 
configurations in the EDK 9.1 Base System Builder Wizard and what Linux 
kernel worked for you? Any suggestions as to why I might not be getting 
any output? Would it be possible for me to use Linux 2.6 or should I 
stick with Linux 2.4? (I feel like Linux 2.4 would be better, but I 
thought I would ask anyway.) Also, are there any known issues with EDK 
9.1 and the XUPV2P? I vaguely remember reading about memory issues 
somewhere, but I can’t remember if they were related to EDK 9.1, EDK 
10.1, or both.

Let me know if I should provide any additional information. Thanks!


-Juliana
