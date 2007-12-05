Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18262.2934.447856.686438@cargo.ozlabs.ibm.com>
Date: Wed, 5 Dec 2007 13:22:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Merge dtc
In-Reply-To: <20071204163409.6d03c7a5@zod.rchland.ibm.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
	<20071204163409.6d03c7a5@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Gibson <david@gibson.dropbear.id.au>,
	David Woodhouse <dwmw2@infradead.org>, David
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> Using that same reasoning, should we merge a mkimage patch for the
> boards that use U-Boot?

I think so.  It's fairly small and it would mean that people could
cross-compile all the defconfigs easily.

Paul.
