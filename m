Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 0BBA6DDE18
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 02:02:00 +1100 (EST)
Date: Tue, 26 Feb 2008 09:01:38 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: copy_from_user problem
Message-ID: <20080226150138.GD16241@localdomain>
References: <47C36FBA.1030600@us.ibm.com> <1203994599.15052.84.camel@pasglop>
	<47C426F8.7070203@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47C426F8.7070203@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maynard Johnson wrote:
> 
> static long lib_addr;
> module_param(lib_addr, long, 0);
                         ^^^^
Should be unsigned long?
