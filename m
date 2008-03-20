Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: simple MPC5200B system
Date: Thu, 20 Mar 2008 10:29:04 +0100
References: <47DF821B.6090600@matrix-vision.de>
	<47E216DA.8080602@matrix-vision.de>
	<20080320082035.GA23860@localhost.localdomain>
In-Reply-To: <20080320082035.GA23860@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803201029.05217.sr@denx.de>
Cc: =?iso-8859-1?q?Andr=E9_Schwarz?= <andre.schwarz@matrix-vision.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 20 March 2008, David Gibson wrote:
> >>> You did build your device tree with "-b 0", didn't you?
> >>
> >> Ugh.. I really need to fix dtc to pick the default boot cpu value more
> >> sensibly, don't I.
> >
> > I didn't specify "-b 0". This shouldn't be neccessary on a single
> > processor system ! After all it's an option ... "0" should be default.
>
> Should, yes.  But dtc's pretty new, and a sensible default for -b is
> one thing that isn't there.

ACK. I have run into a problem on the Sequoia (440EPx) lately, where the FPU 
was not initialized correctly because of the missing "-b 0". Please add this 
as default.

Best regards,
Stefan
