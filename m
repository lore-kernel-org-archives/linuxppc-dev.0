Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id D54CDDDE11
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 01:28:03 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2298624wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 08:28:03 -0700 (PDT)
Message-ID: <fa686aa40708280828h408ce7damf04b31a2048d40c4@mail.gmail.com>
Date: Tue, 28 Aug 2007 09:28:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <Pine.LNX.4.44.0708281714020.4960-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708280810v48d294h87779374e6a7038d@mail.gmail.com>
	<Pine.LNX.4.44.0708281714020.4960-100000@slslc02.psi.ch>
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/28/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> This buffer refers to the kernel which I boot straight from jtag but not
> u-boot.

/me remembers something....

How big is your kernel image?  Seems to me I've had problems with
kernel images that were too large not being uncompressed properly.
Can you hook up GDB and debug u-boot?  Find out where it is hanging?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
