Return-Path: <tnt@246tNt.com>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.3.4]) by ozlabs.org (Postfix) with ESMTP id 312AE2BF0B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 05:29:08 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iATIT0uY008644
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 Nov 2004 19:29:00 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41AB6A82.8070201@246tNt.com>
Date: Mon, 29 Nov 2004 19:29:22 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: roger blofeld <blofeldus@yahoo.com>
References: <20041129174842.14784.qmail@web53506.mail.yahoo.com>
In-Reply-To: <20041129174842.14784.qmail@web53506.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 Cache coherency with BestComm issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Roger

>
>Sylvain,
> You are correct. The CPU_FTR_NEED_COHERENT is not required. Perhaps
>the solution is to only turn on powersave_nap if CONFIG_PPC_BESTCOMM is
>not selected.
>  
>
Pull the latest tree. I've just commented it out with a note.
I didn't rip it off so that people copying lite5200.c for their own 
board know how to activate
it if they need to ...
It can also be controlled from userspace /proc/sys/kernel/powersave-nap

You just need to be aware of the consequences ( like USB not working 
either ! ) if you want
to save power.


    Sylvain
