Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (unknown [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2431DDDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 09:09:32 +1100 (EST)
Received: from mail.gnudd.com (rubini@localhost [127.0.0.1])
	by mail.gnudd.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m03LsuoX020700
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Jan 2008 22:54:56 +0100
Received: (from rubini@localhost)
	by mail.gnudd.com (8.13.4/8.13.4/Submit) id m03Lsuls020697
	for linuxppc-embedded@ozlabs.org; Thu, 3 Jan 2008 22:54:56 +0100
Date: Thu, 3 Jan 2008 22:54:56 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Drivers' probe function calling order
Message-ID: <20080103215456.GA20691@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EC2DE1E@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8EC2DE1E@aquib01a> 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> how can I force the system to call
> probe function of the spi driver first?

You can declare their init functions at different initcall level.  For
example declaring the dataflash one as late_initcall(). Or declare
the spi one as subsys_initcall() -- whatever makes more sense.

There might be cleaner ways according to your setup, but this will
surely work.

/alessandro
