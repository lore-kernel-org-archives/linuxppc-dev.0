From: James Petterson <jpetterson@PARKS.com.br>
Reply-To: James Petterson <jpetterson@PARKS.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain;
  charset="iso-8859-1"
Subject: Re: i can't use the function in kernel??
Date: Mon, 16 Jul 2001 10:10:59 -0300
References: <3B52C152.F5FB58B7@genetel.co.kr>
In-Reply-To: <3B52C152.F5FB58B7@genetel.co.kr>
MIME-Version: 1.0
Message-Id: <01071610105900.01193@james.parks.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you're compiling a module, your output file should be 'network.o':

ppc_8xx-gcc -o network.o network.c

James

On Monday 16 July 2001 07:26, hychon wrote:
> hi!
>
> I write a  sample network device driver based on MPC860T
> but  no experience  any device driver.
> I reference  '/kernel/arch/ppc/8xx_io/enet.c' file  and I wirte a
> program.
>
> when I compile (ppc_8xx-gcc -o network network.c ) , occur error with
> following message
>
> ============== -error ============================================
> ~~/network.c : undefined reference to 'printk'
>  ~~/network.c : relocation truncation to fit : R_PPC_REL24 printk
>
> ~/network.c : undefined reference to 'kmalloc'
>  ~~/network.c : relocation truncation to fit : R_PPC_REL24 kmalloc
> .........
>
> collect2: ld returned 1 exit status
> make: ***[all] Error 1
>
> ==============================================================
>
>  I can't use 'printk()' , kmalloc() etc... function .
>
> I include linux/kernel.h . linux/fs.h , linux/slab.h ...etc ( header
> files of  need by function)
> (reference  the book 'linux device driver ' by ALESSANDRO RUBIN )
>
> why i don't use  those function?
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
