From: Amit Shah <amit.shah@codito.com>
To: huailin@xtrj.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Date: Tue, 11 May 2004 23:01:30 +0530
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.linuxppc.org
References: <20040511172318.88343.qmail@web21412.mail.yahoo.com>
In-Reply-To: <20040511172318.88343.qmail@web21412.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405112301.30665.amit.shah@codito.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

It's pretty strange then that people would come up with boards based on
dual-processors of the 7xx family (like the IBM Argan board or the Xcalibur
boards). Any idea how they use it or what are they intended for?

Amit.

On Tuesday 11 May 2004 22:53, Huailin Chen wrote:
> > My experience has been that MPC750s work in a SMP
> > environment
> > on a 60x bus.  Maybe I was just lucky?  The way I
> > read the manual,
> > they should work with a proper memory controller.
> >
> > Thanks.
>
> 750 MEI protocol does NOT support SMP well. Sure, you
> are right. It works, but not that good.
>
> Ideally, MESI + MPX Bus is the best one for SMP under
> PPC arch. That's why need go to G4+ GT 64360.

--
Amit Shah
Codito Technologies Pvt. Ltd.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
