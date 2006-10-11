Return-Path: <rdcorle@yahoo.com>
Received: from web56312.mail.re3.yahoo.com (web56312.mail.re3.yahoo.com
	[216.252.110.236]) by ozlabs.org (Postfix) with SMTP id 1A52B67BB7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 02:21:31 +1000 (EST)
Message-ID: <20061011161451.3292.qmail@web56312.mail.re3.yahoo.com>
Date: Wed, 11 Oct 2006 09:14:51 -0700 (PDT)
From: robert corley <rdcorle@yahoo.com>
Subject: plb_temac, ML403, linux 2.4.26, EDK 7.1
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Some background:=0A    ML403 devel board=0A    EDK 7.1=0A    compilation of=
 reference design xapp902, modified to use linux and without loopback=0A   =
 use of linux_2_4_devel obtained from montavista via rsync=0A=0AI am trying=
 to use the plb_temac rather than the ll_temac.  In the long run, I'd prefe=
r to stick with linux 2.4.  In addition, I will need to get both embedded E=
MAC's up and running, but first I just wanna get the xapp902 working.  Also=
, I will need gigE support.=0A=0ASo, right now I am trying to get the plb_t=
emac to compile and get errors about the defines XPAR_XTEMAC_* within the l=
inux directories ../drivers/net/xilinx_enet.  I see that the edk gets the d=
efines within the xparameters.h file of the xapp902 project.  I also see th=
at my C:\EDK\sw\ThirdParty\bsp\linux_mvl31_v1_01_a\drivers don't have anyth=
ing for a plb_temac.=0A=0AQ:    Is my error related to an incorrect setup o=
f the linux or with the EDK?=0A=0AQ:    t is stated that the plb_temac driv=
ers are in EDK 8.1.  Can I stick=0Awith 7.1 or must I ugprade?=0A=0AQ:    W=
here in the linux tree should I look for the xtemac=0Astuff?  Is this what =
the EDK pushes on to the tree or is it released=0Awithin the MVL distro?=0A=
=0AQ    Based on posts by David and Ming, it=0Aappears that I must use xili=
nx_gige to get up to gigE speeds.  Will the=0Aplb_temac support this data r=
ate and, if so, is this a transparent=0Asupport or do I need to go the rout=
e suggested to Ming and=0Aoverwrite files in xilinx_enet?=0A=0AR. Corley=0A=
=0A=0A=0A=0A
