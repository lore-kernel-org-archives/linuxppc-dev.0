Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (adsl-203-134.38-151.net24.it [151.38.134.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 751F568882
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 11:25:52 +1100 (EST)
Date: Thu, 8 Dec 2005 01:25:44 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: blofeldus@yahoo.com
Message-ID: <20051208002544.GA25374@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@ar.linux.it
In-Reply-To: <20051207172321.77464.qmail@web53515.mail.yahoo.com>
References: <20051207172321.77464.qmail@web53515.mail.yahoo.com> 
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Video Card to Lite5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> What is the status of the mpc5200 support? I see Sylvain's repository
> is still at 2.6.12 (5 months old).

I just published what I've done (on a previous 2.6.14-rc3 tree by Denx).
It's in ftp://gnudd.com/pub/patches/mpc5200/ (also http://).

I used Sylvain's FEC support, hacked a mb() to make PCI initialize
and ported PIO-mode IDE from 2.4 (with a gross hack about port addresses),
enabled some MTD configurations so cmdlineparts work fine.

/alessandro, who doesn't have a 5200 with him any more.
