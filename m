Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 571AA6889B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 07:40:56 +1100 (EST)
To: Simon Haynes <simon@baydel.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Dec 2005 17:26:34 GMT."
	<200512121726.34944.simon@baydel.com>
Date: Mon, 12 Dec 2005 21:40:54 +0100
Sender: wd@denx.de
Message-Id: <20051212204054.2A1F7353A44@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ibm emac driver update 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200512121726.34944.simon@baydel.com> you wrote:
> I am running a Ebony board with linux-2.6.12-rc1 and I amd having intermittent 
> network problems. Having searched the archives it would seem that the driver
> for the IBM EMAC is buggy ? 

Patches have been posted on this list. See the archives.

> Can anyone point me in the direction of a suitable patch for this kernel ?

We have all this integrated and tested in our kernel tree. Links:
Source Code:
  git repository: 	http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git
  FTP Snapshot: 	ftp://ftp.denx.de/pub/linux/linux-2.6.15-rc2-2005-12-03-2208.tar.bz2
Ready to run code for AMCC's Eval Kits:
  U-Boot images: 	ftp://ftp.denx.de/pub/u-boot/images/amcc/
  Linux images: 	ftp://ftp.denx.de/pub/linux/images/amcc/
Documentation: 		http://www.denx.de/wiki/DULG/BoardSelect



Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We have found all life forms in the galaxy are  capable  of  superior
development.
	-- Kirk, "The Gamesters of Triskelion", stardate 3211.7
