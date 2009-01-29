Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E076FDDF14
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 10:06:09 +1100 (EST)
Message-ID: <49823647.2010701@freescale.com>
Date: Thu, 29 Jan 2009 17:05:43 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: James Black <jblack547@gmail.com>
Subject: Re: mpc8270 and fs_enet
References: <b77025b40901291441j7790f85ewd70ee81dc09ed55b@mail.gmail.com>
In-Reply-To: <b77025b40901291441j7790f85ewd70ee81dc09ed55b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

James Black wrote:
> I've got an mpc8270 running the fs_enet v1.0 driver and we are having
> problems with randomly corrupted tx buffer descriptor ready bits. The
> CPM never clears the bit. This is a 2.6.19.2 kernel. We have the same
> kernel with the 8260_io driver (kernel is from the denx ELDK4.2)
> running on the mpc8250 that works perfect.

Is it possible that some other CPM block is configured to use the same 
DPRAM area that the descriptors are in?

-Scott
