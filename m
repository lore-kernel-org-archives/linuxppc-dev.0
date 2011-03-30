Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id F41EA1007D7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2011 18:58:26 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 16546-02 for <linuxppc-dev@ozlabs.org>;
	Wed, 30 Mar 2011 08:51:41 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 5/5] xhci: Remove recursive call to xhci_handle_event
Date: Wed, 30 Mar 2011 08:51:25 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ACBB@saturn3.aculab.com>
In-Reply-To: <20110329200017.GA25480@dtor-ws.eng.vmware.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Dmitry Torokhov" <dtor@vmware.com>,
	"Matt Evans" <matt@ozlabs.org>
Cc: sarah.a.sharp@linux.intel.com, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > -	xhci_handle_event(xhci);
> > +	while (xhci_handle_event(xhci)) {}
> >=20
>=20
> I must admit I dislike the style with empty loop bodies...

I would use an explicit 'continue;' for the body
of an otherwise empty loop.

	David
