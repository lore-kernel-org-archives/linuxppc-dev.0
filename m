Return-Path: <benh@kernel.crashing.org>
Subject: Re: ring on PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40710302218s3dfe4d42red589fc5692e4c1@mail.gmail.com>
References: <f3566d60710302205g2dd867bbk8a3494ceeda569f0@mail.gmail.com>
	<fa686aa40710302218s3dfe4d42red589fc5692e4c1@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 16:36:36 +1100
Message-Id: <1193808996.9928.112.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-30 at 23:18 -0600, Grant Likely wrote:
> On 10/30/07, Bai Shuwei <baishuwei@gmail.com> wrote:
> > Hi, everyone
> >    As we know, the program on the X86 can run on the differnt ring(0, 1, 2,
> > 3) and the linux kernel run in the ring 0 and user program in the ring 3.
> > And now I want to know wether there is a simple mechanism on the PowerPC
> > architecture? thx all!
> 
> Powerpc has 2 privilege levels; user and supervisor.  The kernel runs
> in supervisor mode, and user-space runs in user mode.

To be complete here, some implementations have 3 :-) Don't forget
hypervisor mode !

Ben.
