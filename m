Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17497.11599.713508.890126@cargo.ozlabs.ibm.com>
Date: Thu, 4 May 2006 08:23:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Wolf <mjw@us.ibm.com>
Subject: Re: [PATCH] define defaultimage for pseries
In-Reply-To: <1146683474.26128.4.camel@localhost.localdomain>
References: <1146683474.26128.4.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Wolf writes:

> Need to define defaultimage in arch/powerpc/Makefile
> so that make rpm will work.

Hmmm.   Why does defaultimage want to be "vmlinux" rather than
"zImage" for pseries?

Paul.
