From: "Meena Ramamoorthi" <meena@stargateip.com>
To: <frowand@mvista.com>, <support@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>, <viswak@yahoo.com>
Subject: RE: kernel thread
Date: Wed, 24 Jan 2001 16:53:44 -0800
Message-ID: <NEBBJELJBMCNBHIPPOHFCEACCBAA.meena@stargateip.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3A6F5059.B2CFE85D@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi Frank,

 I tried this program. When i do insmod hello.o or hello_module.o  it says
unresolved symbol kernel_thread. So the problem is still not resolved.

 Thanks
 Meenakshi


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Frank
Rowand
Sent: Wednesday, January 24, 2001 2:00 PM
To: Meena Ramamoorthi
Cc: linuxppc-embedded@lists.linuxppc.org; frowand@mvista.com
Subject: Re: kernel thread


Meena Ramamoorthi wrote:
>
>   Hi all,
>
>  Has anybody tried using kernel_thread under montavista - IBM 405GP PPC
> hardhat LINUX kernel. ( 2.4 )  If so could you please reply to this. We
have
> problem in exporting this. kernel_thread unresolved.
>
>   Early answer appreciated
>
>  Thanks and best regards,
>  Meenakshi

The symbol is there.  I'll attach a trivial module that accesses the symbol
successfully.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
