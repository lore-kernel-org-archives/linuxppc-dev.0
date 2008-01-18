Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54D10DDED3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 02:51:02 +1100 (EST)
Message-Id: <1C05D4DF-8C6A-4EFD-96F4-07FC75241970@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EC8BBD1@aquib01a>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: A file of 5 MB on tmpfs file system uses 5 MB of RAM or more?
Date: Fri, 18 Jan 2008 09:50:54 -0600
References: <F1F6EC0C8B75034F9E3A79FC85122E8EC8BBD1@aquib01a>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 18, 2008, at 7:15 AM, DI BACCO ANTONIO - technolabs wrote:

> I have a linux-2.6.19.2 board with an MPC880 with 16MB ram and 16 MB  
> flash.
> Normally I have 9-10 MB of free RAM.
>
> If I allocate 5 MB of ram memory, the system continues to work  
> normally, but if, instead of allocating 5 MB directly, I fill the / 
> tmp directory (that has a tmpfs file system) with a 5MB file the  
> system becomes slow and after some minutes the oom_killer is  
> invoked. Before it dies I had the time to see that mtdblockd is  
> taking a lot of CPU (20%), what could be the problem?
>
Posting any output from OOM, etc would be useful.

- k
