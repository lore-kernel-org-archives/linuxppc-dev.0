Message-ID: <XFMail.990309074935.hcaley@loomer.com>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <36E4E107.9C0DC589@mail.esiea.fr>
Date: Tue, 09 Mar 1999 07:49:35 -0500 (EST)
From: Batmensch <hcaley@loomer.com>
To: "G. =?iso-8859-1?Q?Laur=E8s?=" <laures@hp1.esiea.fr>
Subject: Re: PBG3Series and pre-R5:a lot further
Cc: "Dev @ LinuXppc" <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Doesn't work; I get the "psychedelic death screen".  Strangely, if I set the
mclk to 43, the display is still messed up but I can hear the machine continue
to boot.

I don't think I've heard of anyone using atyfb successfully on a 300mhz PB G3
Series.

Hugh


On 09-Mar-99 G. Laurès wrote:
> 
> 
> Batmensch a *crit :
>> 
>> I tried this XF86Config on my PB G3 Series, and although it starts up, it is
>> still running in Open Firmware (non-accelerated mode).
> Does the XFBDev out specifies it's using the ATY Rage PRO device, with
> acceleration enabled ?
> 
> If not, try video=atyfb:vmode:14,cmode:8,mclk:83 as a kernel argument,
> with unchecked "no video driver" box.
> 
> If you not see atyfb;ATY RageLT PRO in the boot sequence (and later in
> /var/log/dmesg) then there is a problem.
> If you do see it, then XFBDev should report it's using the ATY chip, in
> acccelerated mode and things should go... lightning.
> 
>> 
>> Did you try running fbset -i while the Xserver is up?
> I don't have fbset unfortunately, I think I have to grab it from G.U.
> site, yeah ?
> 
>> 
>> I could be wrong, but it seems to me I remember reading somewhere that you
>> can't run XF68_FBDev in accelerated mode when the console is running Ofb.
> Sure.
> 
>> 
>> Xpmac is much faster than Ofb; try moving an open window around.
> I wasn't able to make some use of Xpmac
> 
> 
> -- 
> GoM

----------------------------------
E-Mail: Batmensch <hcaley@loomer.com>
Date: 09-Mar-99
Time: 07:47:47

This message was sent by XFMail
----------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
