Subject: page fault
From: bharat <bharat@coraltele.com>
To: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20820601.1090640061250.JavaMail.administrator@RnDserver>
References: <1090590567.3939.20.camel@localhost.localdomain>	 <20820601.1090640061250.JavaMail.administrator@RnDserver>
Content-Type: text/plain; charset=us-ascii
Message-Id: <18345265.1090641072140.JavaMail.administrator@RnDserver>
Mime-Version: 1.0
Date: 24 Jul 2004 09:22:14 +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all,
i am a newbie,so i may be far behind the curve,but please bear with me.
i am porting hardhat linux for MPPC860T for our custome hardware and i
am not using any bootloader instead i use my custome utility to download
kernel to board,in /arch/ppc/m8xx_setup.c in function m8xx_init i give

	bd_t *binfo;

        binfo =res;

        binfo->bi_memstart=0;
        binfo->bi_memsize=10*1024*1024;
        binfo->bi_intfreq=50;

#ifdef CONFIG_BLK_DEV_INITRD
        initrd_start = 10*1024*1024 + KERNELBASE;
        initrd_end = 16*1024*1024 + KERNELBASE;
#endif
as i want to use 10 mb of my ram for execution and rest up to 16 mb
for file system currently it is nfs mounted.
problem is that it all went ok in kernel space but as soon as it enters
in user space it starts giving PAGE_FAULTS.
how can i remove this.
Thanks in anticipation
--

YOU CAN ACHIEVE ANYTHING BY PROGRAMMING YOUR MIND-SET !

with warm regards
Bharat Bhushan
coral Telecom,Noida
india


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
