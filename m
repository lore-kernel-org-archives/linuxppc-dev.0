Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17038.34542.914436.627219@cargo.ozlabs.ibm.com>
Date: Sat, 21 May 2005 10:55:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <0b53908f87096525543bc4f660c613b6@embeddededge.com>
References: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
	<0b53908f87096525543bc4f660c613b6@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu type explicitly, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek writes:

> Is there now some minimum gcc version that is required for
> using these flags?

Interestingly, gcc-2.95 seems to accept -mcpu=xxx for any xxx.
gcc-3.2 will accept -mcpu=860 but not -mcpu=8540, and gcc-3.3 and
later will accept both.

Paul.
