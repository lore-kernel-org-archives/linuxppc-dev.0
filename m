Message-ID: <002701c39381$dbb5e0e0$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: "Xiaoshan Zuo" <xzuo@vinesystech.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <001d01c39133$20f088a0$2803050a@JackyLam> <3F8B7B3B.60302@vinesystech.com> <004e01c39217$4446ce60$2803050a@JackyLam> <3F8D85A5.8060300@vinesystech.com>
Subject: Re: Walnut PCI bridge can't be detected
Date: Thu, 16 Oct 2003 09:07:21 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Xiaoshan,


> Also you need to remove the #ifndef line in the function
pci_hose_scan_bus()
> #ifndef CONFIG_405GP /* don't skip host bridge on ppc405gp */
> /* Skip our host bridge */
> if ( dev == PCI_BDF(hose->first_busno,0,0) )
> continue;
> #endif
>
> It causes PCIC0_CMD[MA]=0 on the bridge, so it doens't respond to request.
>
        That's what I want. It works!!!!! Really thanks to you. Your mail
will surely help many beginners on Walnut platform.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
