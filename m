From: bharat <bharat@coraltele.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: init not working
Date: Fri, 18 Jun 2004 18:52:38 +0530
References: <15097573.1087559946531.JavaMail.administrator@RnDserver> <22656654.1087563544296.JavaMail.administrator@RnDserver>
In-Reply-To: <22656654.1087563544296.JavaMail.administrator@RnDserver>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <764145.1087564908687.JavaMail.administrator@RnDserver>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Friday 18 Jun 2004 6:29 pm, you wrote:
> On Friday 18 Jun 2004 5:29 pm, you wrote:
> > hi there
> >            i am a novice in this embedded field so know nothing and
> > working on porting hardhat linux(linux kernel version 2.2.14)  to our
> > custome hardware. i donot use any bootloader instead we have self made
> > utility which download uncompressed kernel to  our board and transfer
> > control to it.while givig board info in arch/ppc/kernel/m8xx_setup.c
> >  binfo->bi_memstart=0;
> > binfo->bi_memsize=8*1024*1024;
> > binfo->bi_intfreq=50;
> > #ifdef CONFIG_BLK_DEV_INITRD
> > //defined in  my case
> >         initrd_start = 10*1024*1024 + KERNELBASE;
> >         initrd_end = 16*1024*1024 + KERNELBASE;
> > #endif
> > i choose to import file system from my host by nfs which also works fine
> > as soon as the kernel calls any init(sbin,bin) it starts executing
> > various loops and finally goes hangs and  give me a lot of worries it is
> > happening since last 15 days with me that i cannot  start  my init
> > i also start busybox but the same results can anybody guide  me what
> > should be the problem i think it might be of dynamic link libraries
> > i mount via nfs /opt/hardhat/devkit/ppc/8xx/target directory to my host
> > should i mount any other directory  like powerpc-linux with it so that
> > the shared libraries can be loaded
> > please tell me something about it
> > i am in extreme  condition of frustation
> > hoping any reply
> > bye
> >
> >
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
