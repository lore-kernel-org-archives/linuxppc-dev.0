Date: Thu, 4 May 2000 12:08:21 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Gong Zhuo_sina <gong_zhuo@sina.com.cn>
cc: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Any compact pci driver for MCP750?
In-Reply-To: <003f01bfb18d$c32748e0$4607a8c0@LocalHost>
Message-ID: <Pine.HPX.4.10.10005041203430.234-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 29 Apr 2000, Gong Zhuo_sina wrote:

>
> Hi:
>   I am using CPX8216. I want to run linuxppc on the system board MCP750. Is
> there any device driver which can support DEC21154 (or DEC21554 for MCPN750)
> so that I can operate the memory on board(MCPN750)  through the compact pci
> bus?

For the MCP750, you should have no problems. But to access MCPN750, the
code is not written and even the infrastructure is not (yet) there. some
more work to support non transparent PCI<->PCI bridges is necessary.

For various reasons (getting a larger PCI memory space being the first one
in your case to be able t oaccess several MCPN750 in a single backplane),
you might be interested in my prepboot loader which reorganizes Raven or
Hawk bridges in CHRP mode rather than PreP mode
(ftp:://vlab1.iram.es/linux-2.2/mvme*patch*).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
