Date: Tue, 30 Apr 2002 19:07:49 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Aurel Wisse <aurel_wisse@yahoo.com>,
	<linuxppc-dev@lists.linuxppc.org>,
	yddev <yellowdog-devel@lists.terrasoftsolutions.com>
Subject: Re: Sungem with iMac Rev-B
In-Reply-To: <20020429132638.29518@smtp.adsl.oleane.com>
Message-ID: <Pine.LNX.4.33.0204301829360.30445-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Going through the sourcecode of the sungem, I am not
> >sure however that it will work with older hardware
> >like the iMac Rev-B's Uni-North and the LXT970.
>
> No, you mismatched bmac and gmac. The sungem driver obsoletes
> the gmac one, not the bmac one.
>
> The bmac driver currently don't have PHY control. This could
> eventually be added, since I beleive we actually know how to
> tap the PHY registers when available. Though this need some
> work and I have no hardware to test on, so I'd rather see
> someone who has do the job ;)

Throw some hints (what to write where, approximately) my way and I might
give it a shot.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
