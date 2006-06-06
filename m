Return-Path: <aung.aungkyawsoe@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 4038B67A76
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 00:57:16 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i4so155759wra
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jun 2006 07:57:15 -0700 (PDT)
Message-ID: <d668b9080606060750w59f531f2mda0bf2b465202c8d@mail.gmail.com>
Date: Tue, 6 Jun 2006 16:50:40 +0200
From: "Aung Soe" <aung.aungkyawsoe@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: PowerPC 8266 ADS-PCI(CPM8260) SCC (UART/Ethernet Mode) and SMC in
	UART mode
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_33848_30254029.1149605440916"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_33848_30254029.1149605440916
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All

I am working on PowerPC 8266 ADS-PCI board

 with Montavista Linux with 2.4.20 Kernel to make SCC1, SMC 1& 2

in UART mode, SCC2, 3 & 4 in Ethernet mode, and FCC 2 in Fast

Ethernet Mode; all in NMSI and not TDM. The drivers provided with

2.4.20 Linux on Power PC were refered and reused.

http://lxr.linux.no/source/arch/ppc/8260_io/?v=2.4.20;a=ppc

 When there are only 3 SCCs used in Ethernet mode and the last

SCC in UART mode then the system works well.

But when 2 more SMC are added to the UART serial driver, the SCC

Ethernet network driver is not working after all ports working for a while.

I will be appreciate to hear any pointers and hints.

Thanks in advance.

Sincerley

Aung

------=_Part_33848_30254029.1149605440916
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Dear All</div>
<div>&nbsp;</div>
<div>I am&nbsp;working on PowerPC 8266 ADS-PCI&nbsp;board</div>
<div>&nbsp;</div>
<div>
<div>with Montavista Linux&nbsp;with 2.4.20 Kernel to make SCC1, SMC 1&amp;&nbsp;2 </div>
<div>&nbsp;</div>
<div>in UART mode, SCC2, 3 &amp;&nbsp;4 in Ethernet mode, and FCC 2&nbsp;in Fast </div></div>
<div>&nbsp;</div>
<div>Ethernet Mode; all in NMSI and not TDM. The drivers provided&nbsp;with </div>
<div>&nbsp;</div>
<div>2.4.20&nbsp;Linux on Power PC were refered and reused.</div>
<div>&nbsp;</div>
<div><a href="http://lxr.linux.no/source/arch/ppc/8260_io/?v=2.4.20;a=ppc">http://lxr.linux.no/source/arch/ppc/8260_io/?v=2.4.20;a=ppc</a>&nbsp;</div>
<div>&nbsp;</div>
<div>
<div>When there are only 3 SCCs&nbsp;used in Ethernet mode and the last </div>
<div>&nbsp;</div>
<div>SCC in UART mode then the system works well. </div>
<div>&nbsp;</div></div>
<div>But&nbsp;when 2 more SMC are added to the UART serial driver, the SCC </div>
<div>&nbsp;</div>
<div>Ethernet network driver is not working after all ports working for a while.</div>
<div>&nbsp;</div>
<div>I will be appreciate to hear any pointers and hints.</div>
<div>&nbsp;</div>
<div>Thanks in advance.</div>
<div>&nbsp;</div>
<div>Sincerley</div>
<div>&nbsp;</div>
<div>Aung</div>
<div>&nbsp;</div>

------=_Part_33848_30254029.1149605440916--
