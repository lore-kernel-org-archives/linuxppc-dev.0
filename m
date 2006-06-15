Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 7F11867BD3
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 02:06:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Date: Thu, 15 Jun 2006 18:06:13 +0200
References: <20060614034756.GA6759@monkey.ibm.com>
	<200606151309.40360.arnd@arndb.de>
	<20060615145826.GA3461@monkey.ibm.com>
In-Reply-To: <20060615145826.GA3461@monkey.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606151806.14502.arnd@arndb.de>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 June 2006 16:58, Mike Kravetz wrote:
> But does debugfs have the same one value/one file rule? =A0Thought I could
> dump all the data in a single debugfs file.

Sure, you could. It just makes it a little more complicated. You probably
need to use a seq_file then.

	Arnd <><
