Return-Path: <ajz@cambridgebroadband.com>
Date: Wed, 27 Jul 2005 09:52:32 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: apoorv sangal <apoorvsangal@gmail.com>
Message-Id: <20050727095232.3603abc1.ajz@cambridgebroadband.com>
In-Reply-To: <a7966936050726231628bb1c77@mail.gmail.com>
References: <a796693605070621187c9394d5@mail.gmail.com>
	<20050707101239.1389b917.ajz@cambridgebroadband.com>
	<a7966936050726231628bb1c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Porting Linux On MPC8266 custom board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 27 Jul 2005 11:46:05 +0530
apoorv sangal <apoorvsangal@gmail.com> wrote:

> Hi Alex,
> Thanks a lot for your reply.
> I have been able to procedd further and now I am facing problem in
> mounting root file system.
> As suggested by you in earlier mail about the following :-
> " 
> 1.      linux/init/main.c
>  
>  (which contains the following code
>          #endif
>  #ifdef CONFIG_MTD
>          { "mtdblock", 0x1f00 },
>  #endif
>          { NULL, 0 }
>  };
>  )
> "
> I am not able to find the above mention code snippet in the linux/init/main.c.
> I am using Linux Kerne 2.4.24 which came with eldk.
> Does that mean that i have to deifne CONFIG_MTD myself as i am trying
> to JFFS2 file system ?


The code is definitely in there!

You need to define CONFIG_MTD using make menuconfig (make sure you define it as kernel resident not
as a module).  If you are new to all this read the README in the kernel source directory first.

Alex
