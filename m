Date: Fri, 26 Feb 1999 01:57:07 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: satadru pramanik <satadru@umich.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.2-ac4 compilation errors
In-Reply-To: <Pine.LNX.4.10.9902252258270.32621-200000@beer.pub.umich.edu>
Message-ID: <Pine.LNX.3.96L.990226015604.26965C-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 25 Feb 1999, satadru pramanik wrote:

> I have a compilation failure on a lppc rel 4.1 system  Here's the "make
> vmlinux dying output"  any hints?  please cc to me directly, as I am no
> longer on the list .
> (my dot.config is an adaptaion of the linux-pmac 2.2.1 kernel config,
> enclosed)

If you search the list archives for "trylock" here's a good one:
http://lists.linuxppc.org/listarcs/linuxppc-user/199902/msg01419.html

-Hollis

> 
> gcc -D__KERNEL__ -I/mnt/ibm/sin/src/kernel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring  -c -o init/main.o init/main.c
> gcc -D__KERNEL__ -I/mnt/ibm/sin/src/kernel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DUTS_MACHINE='"ppc"' -c -o init/ve
rsion.o init/version.c
> make -C  kernel
> make[1]: Entering directory `/mnt/ibm/sin/src/kernel/linux/kernel'
> make all_targets
> make[2]: Entering directory `/mnt/ibm/sin/src/kernel/linux/kernel'
> gcc -D__KERNEL__ -I/mnt/ibm/sin/src/kernel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c ksyms.c
> ksyms.c:375: `__down_trylock' undeclared here (not in a function)
> ksyms.c:375: initializer element for `__ksymtab___down_trylock.value' is not constant
> make[2]: *** [ksyms.o] Error 1
> make[2]: Leaving directory `/mnt/ibm/sin/src/kernel/linux/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/mnt/ibm/sin/src/kernel/linux/kernel'
> make: *** [_dir_kernel] Error 2
> 
> --=
> satadru pramanik `satadru@umich.edu' www.umich.edu/~satadru
> MIS, Student Publications
> "I'm old enough to be living in the future I was warned about."
>   - Myron Krueger
> =--
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
