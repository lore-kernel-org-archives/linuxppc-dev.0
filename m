Message-ID: <004e01c39217$4446ce60$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <001d01c39133$20f088a0$2803050a@JackyLam> <3F8B7B3B.60302@vinesystech.com>
Subject: Re: Walnut PCI bridge can't be detected
Date: Tue, 14 Oct 2003 13:51:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I was puzzled by this for a while. Then I saw this code while debugging
> PCI on my custom board:
> In ppc405_pci.c, there is ppc4xx_exclude_device function:
>
> static int
> ppc4xx_exclude_device(unsigned char bus, unsigned char devfn)
> {
> /* We prevent us from seeing ourselves to avoid having
> * the kernel try to remap our BAR #1 and fuck up bus
> * master from external PCI devices
> */
> return (bus == 0 && devfn == 0);
> }
>
> With this function there, there is no way you are going to see the
> bridge, even your driver does the scan itself. I had to write my own
> pci_read_config_<size> function to just to be able to read the bridge
> configration.
>
> Cheers,
>
> Xiaoshan

    Would you made any PCI card working on Walnut before? Do you know any
code modification is needed before? Could you please give me some direction?
Thanks.

Best regards,
Jacky
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
