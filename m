Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 4900267B30
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 21:00:25 +1000 (EST)
Date: Wed, 13 Apr 2005 06:57:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Vijay Padiyar <vijay_padiyar@hotmail.com>
In-Reply-To: <BAY1-DAV1171F1D6CBF80125D8198D8B340@phx.gbl>
Message-ID: <Pine.LNX.4.61.0504130656100.6223@localhost.localdomain>
References: <BAY1-DAV1171F1D6CBF80125D8198D8B340@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: BusyBox Support <busybox@mail.codepoet.org>,
	LinuxPPC Support <linuxppc-embedded@ozlabs.org>
Subject: Re: Can you suggest a small FTP utility for Linux suitable for
 embedded systems?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Apr 2005, Vijay Padiyar wrote:

> Hi there
>
> I am running BusyBox 1.0 on the Linux 2.6.10 kernel on an MPC8260
> target. Since BusyBox currently doesn't appear to provide an FTP
> server utility, I wanted to know where I can get a small FTP utility
> for Linux that doesn't take up much space and is suitable for
> embedded applications.

we're using "ftplib", which comes with both the library and the "qftp"
client.  seems to run well on our 8xx board alongside busybox-1.00.

rday
