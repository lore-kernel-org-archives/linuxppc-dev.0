Message-Id: <200006130707.JAA17893@denx.local.net>
To: Dan Malek <dan@netx4.com>
cc: Lucinda Schafer <lucsch@adaptivemicro.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation Kernel Panic 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Jun 2000 20:47:12 EDT."
             <39458490.234545FC@embeddededge.com>
Date: Tue, 13 Jun 2000 09:07:45 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <39458490.234545FC@embeddededge.com> Dan Malek wrote:
>
> > Wolfgang's suggestion makes a lot of sense to me:
> > "Usually this means that you are running on an old  mask  revision  of
> > the  CPU,  which  still  has  the  (in)famous  "Cache Corruption When
> > Writing to Special Registers" bug."
>
> I believe that only affected some 860(T) processors.  I don't remember
> that listed for any other processor model or silicon.

Unfortunately,  this  silicon  bug  is  present  on  the  early  mask
revisions of _all_ MPC8xx CPUs.

On the MPC823 it's listed as "CPU6. Possible  Data  Cache  Curruption
With  Special Purpose Register Access Located in Data Cache, Data MMU
or SIU" up to and including CPU revision 0.3  (mask  set  3F98S);  it
seems fixed in revision A (mask set 0H98G, 1H98G) and later.

For the MPC850 it's listed as "CPU7. Possible Data  Cache  Curruption
When  Writing  SPRs"  up  to and including CPU revision 0.3 (mask set
3F98S); it seems fixed in revision A  (mask  set  0H98G,  2H98G)  and
later. I have a few samples of MPC850 CPUs labeled as 7F98S which are
not listed by Motorola, which are also affected.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"No matter where you go, there you are..."          - Buckaroo Banzai

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
