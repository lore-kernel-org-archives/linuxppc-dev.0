Message-ID: <009a01bfbb13$559d2d00$4607a8c0@LocalHost>
From: "Gong Zhuo" <gongzhuo@163.net>
To: "linuxppc dev" <linuxppc-dev@lists.linuxppc.org>,
        "Gabriel Paubert" <paubert@iram.es>
References: <Pine.HPX.4.10.10005041203430.234-100000@gra-ux1.iram.es>
Subject: Re: Any compact pci driver for MCP750?
Date: Thu, 11 May 2000 14:37:02 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


----- Original Message -----
From: Gabriel Paubert <paubert@iram.es>
To: Gong Zhuo_sina <gong_zhuo@sina.com.cn>
Cc: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Sent: Thursday, May 04, 2000 6:08 PM
Subject: Re: Any compact pci driver for MCP750?


>
>
> On Sat, 29 Apr 2000, Gong Zhuo_sina wrote:
>
> >
> > Hi:
> >   I am using CPX8216. I want to run linuxppc on the system board MCP750.
Is
> > there any device driver which can support DEC21154 (or DEC21554 for
MCPN750)
> > so that I can operate the memory on board(MCPN750)  through the compact
pci
> > bus?
>
> For the MCP750, you should have no problems. But to access MCPN750, the
> code is not written and even the infrastructure is not (yet) there. some
> more work to support non transparent PCI<->PCI bridges is necessary.
>
> For various reasons (getting a larger PCI memory space being the first one
> in your case to be able t oaccess several MCPN750 in a single backplane),
> you might be interested in my prepboot loader which reorganizes Raven or
> Hawk bridges in CHRP mode rather than PreP mode
> (ftp:://vlab1.iram.es/linux-2.2/mvme*patch*).
>
In fact , I am moving from VME bus to CompactPCI bus . I have used your VME
bus drivers for MVME2600 and it is very good . Thank you very much. Does you
meaning there is  a similar driver for DEC21154(MCP750) so that 'open'
'close' 'mmap' and so on can be done on C-PCI just like your VME bus
drivers?

 Regards,
Gong Zhuo.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
