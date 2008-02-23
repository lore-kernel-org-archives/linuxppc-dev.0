Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18368.41140.613039.856940@cargo.ozlabs.ibm.com>
Date: Sun, 24 Feb 2008 09:39:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 5/5] [POWERPC] Add 460EX PCIe support to 4xx pci driver
In-Reply-To: <1203799608.6976.44.camel@pasglop>
References: <1203602482-11415-1-git-send-email-sr@denx.de>
	<18367.34338.962846.402664@cargo.ozlabs.ibm.com>
	<1203799608.6976.44.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> Actually, the patch just adds a backend to my little framework for
> dealing with 4xx PCIe, which basically is a boring piece of code
> filling registers with values mostly from the spec... nothing really
> fancy there.

OK, then that's what the patch description should tell us...

Paul.
