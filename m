Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id BD34F67A67
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 08:28:15 +1100 (EST)
To: "Stephen Warren" <SWarren@nvidia.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Mar 2005 12:16:12 PST."
	<DBFABB80F7FD3143A911F9E6CFD477B0056A92E3@hqemmail02.nvidia.com>
Date: Tue, 08 Mar 2005 22:27:49 +0100
Sender: wd@denx.de
Message-Id: <20050308212754.E35A5C1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 kernel with IDE *and* FEC? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <DBFABB80F7FD3143A911F9E6CFD477B0056A92E3@hqemmail02.nvidia.com> you wrote:
>
> http://www.denx.de/twiki/bin/view/DULG/DebianOnPowerpcInstallationHowto 
> 
> That could save a lot of time, but is this kernel 2.4-based? The docs
> there imply that (buildling a kernel natively section references paths
> with 2_4 in them).

Yes, it is.

> We already have a 2.4-based MontaVista, but we're trying to get a 2.6
> kernel up and running with NPTL to compare the pthreads performance
> differences...

You can probably use  the  2.4  kernel  for  installation  (or  -  as
mentioned  before  -  just use another PPC box and transfewr the disk
drive).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
When properly administered, vacations do not  diminish  productivity:
for every week you're away and get nothing done, there's another when
your boss is away and you get twice as much done.  -- Daniel B. Luten
