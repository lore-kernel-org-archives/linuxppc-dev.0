Return-Path: <hollisb@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CCDCFB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 01:49:04 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n58FjJ6U012719
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jun 2009 09:45:19 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n58FmxKC082806
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jun 2009 09:48:59 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n58FmwKk032403
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jun 2009 09:48:58 -0600
Subject: Re: mkimage for ppc
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4A24F20E.2020508@redhat.com>
References: <4A24F20E.2020508@redhat.com>
Content-Type: text/plain
Date: Mon, 08 Jun 2009 10:48:58 -0500
Message-Id: <1244476138.16253.22.camel@slate.austin.ibm.com>
Mime-Version: 1.0
Cc: u-boot@lists.denx.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry, was on vacation. Copying a couple mailing lists...

On Tue, 2009-06-02 at 12:34 +0300, Avi Kivity wrote:
> I am now doing regular build tests on various platforms (kernel only for 
> now).

That's great! Much appreciated.

> But ppc wants a mkimage and I don't have one to give it.  Where 
> can I find it?

mkimage is a tool provided by u-boot
(http://git.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=summary). IIRC
people have discussed the need to include a copy in the kernel source in
the past, but apparently nothing was ever done about it.

-- 
Hollis Blanchard
IBM Linux Technology Center
