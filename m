Message-ID: <3B5BA1A4.CF1BA180@genetel.co.kr>
Date: Mon, 23 Jul 2001 13:01:45 +0900
From: hychon <hychon@genetel.co.kr>
Reply-To: hychon@genetel.co.kr
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: how to get a physical address?
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi~~

I want to know "how to get a physical address from mmaped area??"

I find  some information  variable vitrual address is  "from
3G+physical_memory_size + 8M to 4G" here mailing site.

my case , 32M ram

I allocate vitrual address throgh by following

 mem1_chy = open("/dev/kmem", O_RDWR);
 chy_addr1 = mmap(0, 64*1024,(PROT_READ|PROT_WRITE),MAP_SHARED, mem1_chy

,0xFF000000 );
  printf(" address : chy_addr1 = %x   \n", chy_addr );

      --->  result =>   address : chy_addr1 = 30027000

 and

  mem2_chy = open("/dev/kmem", O_RDWR);
  chy_addr2 = mmap(0, 64*1024,(PROT_READ|PROT_WRITE),MAP_SHARED,
mem2_chy , 0x100000 );
  printf(" address : chy_addr2 = %x   \n", chy_addr2 );

      --->  result =>   address : chy_addr2 = 30016000


how a get a phyisical address of chy_addr2 (chy_addr1) ??
 chy_addr 2is not return "100000" .      wondering??

I want  a little  information about "from 3G+physical_memory_size + 8M
to 4G"?
 - why it add 8M ?

anyway, I want to know get a physical address from VMA araa??


                                             --  hye yong --


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
