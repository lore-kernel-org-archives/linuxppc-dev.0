Message-ID: <36E4E107.9C0DC589@mail.esiea.fr>
Date: Tue, 09 Mar 1999 09:51:22 +0100
From: "G. =?iso-8859-1?Q?Laur=E8s?=" <laures@hp1.esiea.fr>
Reply-To: laures@hp1.esiea.fr
MIME-Version: 1.0
To: Batmensch <hcaley@loomer.com>,
        "Dev @ LinuXppc" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PBG3Series and pre-R5:a lot further
References: <XFMail.990308075819.hcaley@loomer.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Batmensch a *crit :
> 
> I tried this XF86Config on my PB G3 Series, and although it starts up, it is
> still running in Open Firmware (non-accelerated mode).
Does the XFBDev out specifies it's using the ATY Rage PRO device, with
acceleration enabled ?

If not, try video=atyfb:vmode:14,cmode:8,mclk:83 as a kernel argument,
with unchecked "no video driver" box.

If you not see atyfb;ATY RageLT PRO in the boot sequence (and later in
/var/log/dmesg) then there is a problem.
If you do see it, then XFBDev should report it's using the ATY chip, in
acccelerated mode and things should go... lightning.

> 
> Did you try running fbset -i while the Xserver is up?
I don't have fbset unfortunately, I think I have to grab it from G.U.
site, yeah ?

> 
> I could be wrong, but it seems to me I remember reading somewhere that you
> can't run XF68_FBDev in accelerated mode when the console is running Ofb.
Sure.

> 
> Xpmac is much faster than Ofb; try moving an open window around.
I wasn't able to make some use of Xpmac


-- 
GoM

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
