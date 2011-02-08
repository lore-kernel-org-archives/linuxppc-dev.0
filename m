Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 16D90B7127
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 20:01:19 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 32477-02 for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 09:01:12 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	InterfaceLayer
Date: Tue, 8 Feb 2011 08:58:49 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC41@saturn3.aculab.com>
In-Reply-To: <4d3a1de3bf1ff8a4f69bf2d90da0a1cf@mail.gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> [Marri] If u32 is 8bytes isn't pointer type would be 8bytes=20
> as well.

If u32 is 8bytes 'char' would only be 4 bits!

(IIRC the X code has a fubar that requires a type with 32
in its name to be 64 bits!)

	David
