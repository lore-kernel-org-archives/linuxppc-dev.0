Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ethtool failure with tulip 21143
Date: Thu, 27 Dec 2001 08:41:17 -0500
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <p04330101b842de27485b@[24.163.44.170]> <20011216233853.23752@smtp.wanadoo.fr> <p04330100b8504e9e9393@[66.57.250.32]>
In-Reply-To: <p04330100b8504e9e9393@[66.57.250.32]>
MIME-Version: 1.0
Message-Id: <20011227133806.LHYR14868.tomts13-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Stefan,

Try sending a patch to Jeff Garzik <jgarzik@mandrakesoft.com> the tulip
maintainer that implements this fix.  I have had good luck getting him to
incorporate patches for the PNIC_II driver so if you send him a tested
patch (against the latest 2.4.x kernel), I am sure he will consider it.

Kevin



On December 26, 2001 11:13, Stefan Jeglinski wrote:
> >  >>Try defining CACHE_ALIGN to CAL_32LONG, and DESC_ALIGN to u32
> >  >> dummy[4]
> >>>
> >>>(as in the commented out example).
> >>
> >>I will look at the de4x5 code again and try this. It's all vaguely
> >>
> >  >familiar to me... Thanks much!
>
> Yes, it has painfully all come back to me now. I originally switched
> to the tulip driver because the de4x5 driver did not function with
> the Farallon 10/100 PCI NIC, and I have now reconfirmed this. There
> are no error messages when loading the module, but there is some
> problem I can't diagnose. The switch lights indicating "it's alive"
> never come on, and the network is not ever reachable. With the tulip
> driver I can at least get that.
>
> I remember further contacting the de4x5 maintainer about this, and
> his response with apologies was that the driver is no longer being
> maintained.
>
> I remember even further contacting Donald Becker about somehow
> inserting this cache alignment fix into the tulip driver. No
> response. So, any thoughts on how to proceed? I have no idea how to
> get the fix into tulip to test...
>
>
> Stefan Jeglinski
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
