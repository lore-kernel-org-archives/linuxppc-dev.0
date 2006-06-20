Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6EB5667B2C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 05:30:10 +1000 (EST)
To: Kimmo Surakka <kimmo.surakka@oxinst.fi>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Lite5200 NFS mount issue 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Jun 2006 15:03:27 +0300."
	<200606201503.27928.kimmo.surakka@oxinst.fi>
Date: Tue, 20 Jun 2006 21:30:08 +0200
Sender: wd@denx.de
Message-Id: <20060620193008.6A56E353CB4@atlas.denx.de>
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

In message <200606201503.27928.kimmo.surakka@oxinst.fi> you wrote:
> 
> Try adding the ",tcp" to the kernel's "nfsroot=..." parameter, i.e. use 
> commandline "root=/dev/nfs rw nfsroot=10.3.67.98:/opt/eldk_4_0/ppc_6xx,tcp 
> ip=10.3.67.99:10.3.67.98:10.3.67.1:::eth0:off panic=1".

This should not be necessary. If it does help,  this  means  you  are
just covering a bug.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Those who hate and fight must stop themselves -- otherwise it is  not
stopped.
	-- Spock, "Day of the Dove", stardate unknown
