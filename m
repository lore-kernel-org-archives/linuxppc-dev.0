Return-Path: <Stephan.Bross@liebherr.com>
Received: from ZDVSV010A.liebherr.com (zdvsv010a.liebherr.com [193.27.220.102])
	by ozlabs.org (Postfix) with ESMTP id 70D4FB6F09
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 23:52:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [ibm_emac] rx_dropped_stack
Date: Thu, 10 Dec 2009 13:36:26 +0100
Message-ID: <82C37E87E8EBA240A1B5B753DE08EC4D0172FE0A@lwesv0088.lwe.liebherr.i>
From: "Bross Stephan (LWE)" <Stephan.Bross@liebherr.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I am using linux version 2.6.25.20 on
cpu             : 440GRX
revision        : 24.212 (pvr 2162 18d4)
bogomips        : 995.32
vendor          : AMCC
machine         : PPC440EPx LWMON5

I am using ethtool to read out NIC statistics. On every tested board I =
saw the counter increasing for 'rx_dropped_stack', on some boards also =
for 'rx_bd_errors', 'rx_bd_bad_fcs' and on few boards for 'tx_underrun' =
or 'tx_dropped'. Can you help me interpret those values? Which values =
are nice for information, which are really bad?

thanks in advance,
Stephan

Liebherr-Werk Ehingen GmbH
Dr.-Hans-Liebherr-Str. 1
89584 Ehingen
E-Mail:		Stephan.Bross@liebherr.com
Internet:	http://www.liebherr.com


Vorsitzender des Aufsichtsrats: Dipl.-Volksw. Henning Rapp
Gesch=E4ftsf=FChrer: Dr.-Ing. Ulrich Hamme, Dr.-Ing. Hubert Hummel, =
Dipl.-Ing. (FH) Christoph Kleiner, Dipl.-Kfm. Mario Trunzer
Sitz: 89584 Ehingen/Donau, Amtsgericht Ulm/Donau, HRB 490123, Ust-Id. =
Nr.: DE 811120093
LIEBHERRB2B4EM@IL
