Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: spidernet: add improved phy support in sungem_phy.c
Date: Thu, 1 Feb 2007 11:55:48 +0100
References: <200701261407.48237.jens@de.ibm.com>
	<20070126233809.GA16660@electric-eye.fr.zoreil.com>
	<20070130223050.GE5616@austin.ibm.com>
In-Reply-To: <20070130223050.GE5616@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702011155.48664.jens@de.ibm.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, James K Lewis <jim@jklewis.com>,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	jgarzik@pobox.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 30 January 2007 11:30 pm, Linas Vepstas wrote:

> Shifting to the right by 5 bits has no effect on the result
> of this conditional. Either the bit is set, or its not.
> There is no need to shift.
> 
> > +	if ( (phy_reg & 0x0020) >> 7 ) {

You are right, I corrected this.

> The result here will always be zero, since the bit,
> if set, will be shifted off the end. Bits on the lef
> are padded with zero.  Ergo, this is a bug.

You are right, wrong bit. I corrected this.

Jens
