Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F5D8DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 12:50:48 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0U1oikA014716
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 20:50:44 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0U1oik1175968
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 18:50:44 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0U1oibt008410
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 18:50:44 -0700
Date: Tue, 29 Jan 2008 19:49:42 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jie han <jiehanca@yahoo.com.cn>
Subject: Re: Help: I will port amcc yucca board to denx kernel ARCH=powepc
	directory.How to config dts file?
Message-ID: <20080129194942.3f9aaecd@zod.rchland.ibm.com>
In-Reply-To: <593873.20606.qm@web15102.mail.cnb.yahoo.com>
References: <593873.20606.qm@web15102.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 29 Jan 2008 16:11:35 -0800 (PST)
jie han <jiehanca@yahoo.com.cn> wrote:

> Hi all,
> I want to port amcc yucca board denx linux kernel from ARCH=ppc to ARCH=powerpc. I used sequoia.dts for yucca baord demo device tree file.

I would start with the Katmai DTS instead.  It's at least the same CPU
type.

josh
