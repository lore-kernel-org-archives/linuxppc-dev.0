Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-20.bluehost.com (outbound-mail-20.bluehost.com
	[70.98.111.235]) by ozlabs.org (Postfix) with SMTP id EA0E7689F3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 15:26:38 +1100 (EST)
Message-ID: <43BF42AA.8030906@secretlab.ca>
Date: Fri, 06 Jan 2006 21:25:14 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Paul Janzen <pcj@linux.sez.to>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <E1EtnU9-0008HI-I0@spohr.debian.org>	<20051230171705.32043.38767.reportbug@sengor.ath.cx>	<handler.345424.D345424.113629990832428.notifdone@bugs.debian.org>	<43BCFA15.5070304@gmx.de>
	<43BD43A0.5060509@secretlab.ca> <oqr77koggf.fsf@merlin.sez.to>
In-Reply-To: <oqr77koggf.fsf@merlin.sez.to>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Heutling <sheutlin@gmx.de>, Paul Mackerras <paulus@samba.org>
Subject: Re: How to build the zImage.prep was Re: Bug#345424 acknowledged
 by developer         (Bug#345424: fixed in linux-2.6 2.6.15-1)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Paul Janzen wrote:
> grant.likely at secretlab.ca (Grant Likely) writes:
> 
> 
>>Have you tried 2.6.14?  I'm having a similar issue with PReP images
>>using QEMU.  2.6.14 works, but 2.6.15 is busted.  It *might* be the same
>>issue.
>>
>>http://ozlabs.org/pipermail/linuxppc-dev/2005-December/020782.html
>>
>>I was able to use git-bisect to narrow it down to 20 or so changes, but
>>I didn't get any farther.
> 
> 
> This *might* be the problem described in: 
> 
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021550.html
> 
> It matches the git-bisect ID's you narrowed it down to, and it matches
> the problem report.  I'm just not sure if it matches the environment
> you're running in. 

Yes, that's exactly it.  QEMU boots prep images again with that patch.
Thank you.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
