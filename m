Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4446DDDF7
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 00:01:16 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1ND1Drp017612
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 08:01:13 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1ND1DxO213032
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 06:01:13 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1ND1C3N015932
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 06:01:13 -0700
Date: Sat, 23 Feb 2008 07:00:44 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/5] [POWERPC] Add AMCC 460EX/460GT support to
	cputable.c & cpu_setup_44x.S
Message-ID: <20080223070044.5ebcb3f1@zod.rchland.ibm.com>
In-Reply-To: <18367.34134.510940.418464@cargo.ozlabs.ibm.com>
References: <1203602435-11302-1-git-send-email-sr@denx.de>
	<18367.34134.510940.418464@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 23 Feb 2008 13:30:46 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Stefan Roese writes:
> 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> 
> That's a very uninformative commit message. :)
> 
> How about putting a brief description of the AMCC 460 family in here?

It's rather boring at the moment.  460EX and 460GT are using a 440
core.  But mentioning that is also important I would think.

josh
