Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp3.wanadoo.fr (smtp3.wanadoo.fr [193.252.22.28])
	by ozlabs.org (Postfix) with ESMTP id 18E4A67A76
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2005 03:52:03 +1100 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0306.wanadoo.fr (SMTP Server) with ESMTP id 222651C00354
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2005 17:51:56 +0100 (CET)
Date: Fri, 18 Mar 2005 17:37:13 +0100
To: "Brian V. Madzarevic" <Brian.Madzarevic@uav.com>
Message-ID: <20050318163713.GA9798@pegasos>
References: <A79EE6739F2C7348A857541FB5CD92D6011566F6@asimail1.rb.uav.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <A79EE6739F2C7348A857541FB5CD92D6011566F6@asimail1.rb.uav.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: 2.6.11 prep powerstack and sym53c8xx brokeness (was Re: 2.6.11 prep
	image on radstone ppc4a not booting)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 10:11:31AM -0800, Brian V. Madzarevic wrote:
> I am trying to boot a Linux 2.6.11 prep image on a Radstone PPC4A.
> PPC4A Specifications http://www.radstone.com/rtcd/pdfs/ppc4a.pdf
> 
> I was trying to get an nfs filesystem mounted, but after the bios
> retrieves the kernel using tftp, no more packets are even sent out.  I
> don't know if there is a problem with the network driver or the PCI bus
> or what.

By the way, i can confirm that the 2.6.11 kernels seem to be broken on
motorola powerstack, due to the sym53c8xx driver which was already mentioned
previously i think.

Any hint on this ? 

Friendly,

Sven Luther
