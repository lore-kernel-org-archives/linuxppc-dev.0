Date: Sat, 12 Apr 2003 15:05:25 -0700
From: Ira Weiny <iweiny@acm.org>
Subject: Re: Machine Check question
In-reply-to: <16021.61655.348425.683335@nanango.paulus.ozlabs.org>
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Message-id: <20030412150525.248091e5.iweiny@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
References: <20030410013241.3ae349e5.iweiny@acm.org>
 <16021.61655.348425.683335@nanango.paulus.ozlabs.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 11 Apr 2003 08:31:51 +1000 (EST)
Paul Mackerras <paulus@samba.org> wrote:

> Ira Weiny writes:
>
> > I have put some more effort into my Microdrive (PCMCIA IDE) problem.
>
> What sort of machine do you have?  There is a known problem on tibooks
> where the IDE subsystem ends up trying to use powermac-IDE functions
> on PCMCIA IDE drives.
>
> Paul.

Yes this is a TiBook.  500Mhz about 2 years old...

[root@batwing2 iweiny]# cat /proc/cpuinfo
cpu		: 7410, altivec supported
temperature 	: 10-12 C (uncalibrated)
clock		: 500MHz
revision	: 17.3 (pvr 800c 1103)
bogomips	: 996.14
machine		: PowerBook3,2
motherboard	: PowerBook3,2 MacRISC2 MacRISC Power Macintosh
detected as	: 71 (PowerBook Titanium)
pmac flags	: 0000000b
L2 cache	: 1024K unified
memory		: 512MB
pmac-generation	: NewWorld
[root@batwing2 iweiny]#


I assume the problem does not have a solution?  If so I would be most
interested in trying to figure it out.  Or is there a work around?

This worked on my 2.4.14-pre7-ben0.

Thanks,
Ira Weiny
iweiny@acm.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
