Date: Thu, 5 Jun 2003 17:58:50 +0900
Subject: Re: Wrong BAT mapping message in dmesg
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
In-Reply-To: <1054798370.700.14.camel@gaston>
Message-Id: <ECE5A6A9-9733-11D7-ABA8-00039394E428@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 2003.6.5, at 04:32  PM, Benjamin Herrenschmidt wrote:

>>   It should be "(total_lowmem - __bat2 - __bat3) >>20" for residual,
>> isn't it?
>
> Yup, I though I fixed that message, must have missed it...

It is on linuxppc_2_4 stable tree.  I didn't mention in previous mail,
sorry.

>> I recently created Linux-2.4 for NuBus PowerMac repository with
>> bitkeeper.  If anyone has interested in this, please look at
>> http://nubus-pmac.bkbits.net/.  This nubus tree is originally derived
>> from Takashi Oe's 2.4.6-pre3 patch, and I've maintained since
>> 2.4.19-something.
>
> Ah great. I was wondering what was the status. What about 2.5 ? Do
> you have any intend to go there ?

It is based on linuxppc_2_4 stable tree (now 2.4.21-rc7), and it is
quite stable on both PPC601 PowerMacs (6/7/8100) and PPC603(e)
Performa.  I think nubus patch doesn't cause any big problem on normal
PowerMac since vmlinux made from the nubus tree works fine on my old
PCI PowerMac (UMAX C500), but not yet checked in great detail.  One
thing I haven't port current linuxppc_2_4 code to NuBus is idle_6xx.S.
NuBus kernel still use old power_save().


Porting of kernel 2.5 doesn't occur yet.  Nobody on linuxppc-nubus
mailing list started yet.  But I just tested 2.5.70 on my old UMAX C500
and confirmed to work on PPC603ev machine today (although valkyriefb.c
is needed to fix a little bit),  So I'll try to port 2.5 to NuBus
PowerMac in some extra time.

--
Etsushi Kato
ekato@ees.hokudai.ac.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
