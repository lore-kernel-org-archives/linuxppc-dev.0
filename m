Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 71525DDE08
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 16:02:30 +1100 (EST)
Date: Thu, 4 Dec 2008 00:02:26 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: USB reset errors in 2.6.28*
Message-ID: <20081204000226.558e68a2@lappy.seanm.ca>
In-Reply-To: <20081204042607.GC18027@kroah.com>
References: <20081203202953.1f9f3065@lappy.seanm.ca>
	<20081204042607.GC18027@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 3 Dec 2008 20:26:07 -0800
"Greg KH" <greg@kroah.com> wrote:

> On Wed, Dec 03, 2008 at 08:29:53PM -0500, Sean MacLennan wrote:
> > 
> > It then seems to work, but I see corruption on the usb key. I
> > haven't looked into it too much since we aren't switching to 2.6.28
> > anytime soon (it breaks our Secure Digital card driver).
> 
> What driver is that?  Why would 2.6.28 be broken?  If it's an
> out-of-tree driver, please let me know and I'll be glad to get it
> merged.

I am embarrassed to say that I tried the usb with 2.6.28-rc7 and it
seems to be fixed. I should have tried it with 2.6.28-rc7 *before*
sending the error report :(

Cheers,
  Sean
