Return-Path: <david-b@pacbell.net>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by ozlabs.org (Postfix) with SMTP id AEED8DDF6C
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 04:53:09 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
Date: Wed, 23 Jan 2008 09:53:05 -0800
References: <20080121103434.397382000@sunsite.dk>
	<87sl0qzxos.fsf@macbook.be.48ers.dk>
	<fa686aa40801230912m2314209fp2545898949ed3b24@mail.gmail.com>
In-Reply-To: <fa686aa40801230912m2314209fp2545898949ed3b24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801230953.05921.david-b@pacbell.net>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 23 January 2008, Grant Likely wrote:
> The question is about the device structure which used to be provided
> by the platform device instances and now there just uses the c67x00's
> device struct.  I was under the impression that each USB HCD needs to
> have it's own struct device.  I take it that's not true?

Each root hub necessarily is a unique device, representing a set
of downstream links.  Unless Peter didn't test something relevant,
it would seem we have observational proof that two root hubs can
share the same device node for an upstream link.

I can't think of a reason to demand multiple upstream links, though
sharing them between root hubs like that isn't a common structure.  

- Dave
