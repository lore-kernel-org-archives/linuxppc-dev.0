Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57C14DE071
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 11:15:33 +1000 (EST)
Date: Sat, 25 Aug 2007 02:15:24 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] fix undefined reference to device_power_up/resume
Message-ID: <20070825011524.GX21089@ftp.linux.org.uk>
References: <20070824194201.GA8737@aepfle.de>
	<18127.33141.119362.34178@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18127.33141.119362.34178@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 25, 2007 at 11:10:13AM +1000, Paul Mackerras wrote:
> Olaf Hering writes:
> 
> > So change even more places from PM to PM_SLEEP to allow linking.
> 
> What config shows these errors?  I presume you need to have CONFIG_PM
> but not CONFIG_PM_SLEEP in order to see them?

E.g. PM, PPC32, SMP.
