Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id ECE1867B7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Oct 2006 00:14:49 +1000 (EST)
In-Reply-To: <CAB1644F1C94A24BAC68B05D0F9774635CC446@VIECLEX01.frequentis.frq>
References: <CAB1644F1C94A24BAC68B05D0F9774635CC446@VIECLEX01.frequentis.frq>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <676F279D-18AA-4B3C-8FDF-CEA73019B366@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: MPC834x TSECs/Gianfar w/o MDIO accessible PHYs
Date: Tue, 24 Oct 2006 10:14:44 -0400
To: KRONSTORFER Horst <Horst.KRONSTORFER@frequentis.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 24, 2006, at 5:16 AM, KRONSTORFER Horst wrote:

> i therefore 'simply' removed the mdio bus and phy support and tested
> with ping over tsec0.

My experience with similar designs is you can't just
remove the knowledge of the phy from the driver.  You
have to "fake" some kind of phy that causes the driver
to initialize the tsec properly.

With more people using this kind of design, it would
be nice if we could extend the phy support to more
generally allow this.   For now, you will have to make
some code modifications that basically result in the
phy functions "finding" a phy and properly initializing
the data structure information to match the connection
between the tsec and the switch.

Thanks.

	-- Dan
