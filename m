Subject: Re: Interfaces supported on PPC860?
To: jason_wohlgemuth@gilbarco.com (Wohlgemuth, Jason)
Date: Fri, 7 Apr 2000 11:16:15 +1000 (EST)
Cc: DBrown03@harris.com ("'Brown, David (dbrown03)'"),
        linuxppc-embedded@lists.linuxppc.org ('linuxppc-embedded@lists.linuxppc.org')
In-Reply-To: <200004061620.MAA07501@hoover.gilbarco.com> from "Wohlgemuth, Jason" at Apr 06, 2000 12:20:54 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000407011615.C0BD63C9C8@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wohlgemuth, Jason writes:
> Off the top of my head, I am pretty sure that you will not be able to
> support RTS/CTS flow control over the  SMC/SCC's, I believe that at one time
> we thought that the SCC's could do it but it isn't truely done in hardware.

I know SMC flow control isn't supported because the CPM hardware doesn't
support SMC flow control, but I was under the impression that SCC flow control
was supported.

Can anyone elaborate on this for me please?

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
