MIME-Version: 1.0
Message-Id: <392B72E2.18374@mta1>
Date: Wed, 24 May 2000 14:12:50 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: Steve Tarr <tarr@lucent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: my port problem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>David--
>I'm also trying to port to Motorola MPC8260ADS board. You seem to be >a bit ahead
>of me .  I am working off the 2.3.99-pre7 release. I have modified >8260_io/uart.c to
>support both SCC1 and SCC2 only. Have not gotten the FCC  Ethernet >working yet.
How did you boot the kernel?What boot message did you get?
I find something wrong with get_free_page() now.
I cannot return from get_free_page() in init_dev() in tty_io.c.
I display the free mem ,it report it has 0kb nonDMAable mem,buf above
8000k DMAable mems(i based on 2.2 kernel,i see in 2.3,it does not
has two array for these two type of mem),although __get_free_page()
will try this two array one by one,but is does not return.So i am
checking it now.Does someone can give me some hints?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
