Return-Path: <kimmo.surakka@oxinst.fi>
Received: from imap.oxinst.fi (unknown [62.236.216.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82FCC67A63
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 22:08:37 +1000 (EST)
From: Kimmo Surakka <kimmo.surakka@oxinst.fi>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Lite5200 NFS mount issue
Date: Wed, 21 Jun 2006 15:15:23 +0300
References: <20060620193008.6A56E353CB4@atlas.denx.de>
In-Reply-To: <20060620193008.6A56E353CB4@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606211515.24362.kimmo.surakka@oxinst.fi>
Cc: Bjorn.Ostby@combitech.se, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 20 June 2006 22:30, Wolfgang Denk wrote:
> In message <200606201503.27928.kimmo.surakka@oxinst.fi> you wrote:
> > Try adding the ",tcp" to the kernel's "nfsroot=..." parameter, i.e. use
> > commandline "root=/dev/nfs rw
> > nfsroot=10.3.67.98:/opt/eldk_4_0/ppc_6xx,tcp
> > ip=10.3.67.99:10.3.67.98:10.3.67.1:::eth0:off panic=1".
>
> This should not be necessary. If it does help,  this  means  you  are
> just covering a bug.

Yes, it may be just covering a bug. Still, it made the connection work, and 
that was enough for me. Also, the linux NFS faq at nfs.sourceforge.net 
suggests using TCP in some situations (namely when the network has a large 
number of IP fragmentation). So, be it a mere work-around or not, it still 
helped me. If there's a better and purer solution, I'm more than happy to use 
it. Meanwhile, I use what works.

Cheers,

Kimmo Surakka

This message has been scanned by F-Secure Anti-Virus

###  OXFORD INSTRUMENTS   http://www.oxford-instruments.com/  ###

Unless stated above to be non-confidential, this E-mail and any
attachments are private and confidential and are for the addressee
only and may not be used, copied or disclosed save to the addressee.
If you have received this E-mail in error please notify us upon receipt
and delete it from your records. Internet communications are not secure
and Oxford Instruments is not responsible for their abuse by third
parties nor for any alteration or corruption in transmission.
