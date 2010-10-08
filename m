Return-Path: <pat@computer-refuge.org>
Received: from mailhub249.itcs.purdue.edu (mailhub249.itcs.purdue.edu
	[128.210.5.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.purdue.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2E62B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 14:41:00 +1100 (EST)
Received: from comet.localnet (173-15-37-149-Illinois.hfc.comcastbusiness.net
	[173.15.37.149]) (authenticated bits=0)
	by mailhub249.itcs.purdue.edu (8.14.4/8.14.4/mta1-auth.smtp.purdue.edu)
	with ESMTP id o983OYUm025627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Oct 2010 23:24:35 -0400
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Problem with Infiniband adapter on IBM p550
From: Patrick Finnegan <pat@computer-refuge.org>
Date: Thu, 7 Oct 2010 23:24:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201010072324.33062.pat@computer-refuge.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I seem to be running into a problem getting a Mellanox Infinihost  
Infiniband adapter working on my IBM p550 (a 9113-550).  I'm using 
Debian squeeze, and tried upgrading to the 2.6.35.7 kernel without any 
help.

I get the following messages in dmesg:
[    4.972548] ib_mthca: Mellanox InfiniBand HCA driver v1.0 (April 4, 
2008)
[    4.972564] ib_mthca: Initializing 0000:c1:00.0
[    4.972674] ib_mthca 0000:c1:00.0: Missing DCS, aborting.


The problem looks the same as a problem I ran into with OpenFirmware on 
a Sun V880, which was fixed with this patch by Dave Miller:
http://ns3.spinics.net/lists/linux-rdma/msg01779.html

I spent some time looking at the equivalent function on powerpc, but 
didn't a block of code that looked similar.

Any suggestions?

I have dmesg, the dev .properties from openfirmware, and lspci -v from 
the machine:

http://ned.rcac.purdue.edu/p550-ib/dmesg
http://ned.rcac.purdue.edu/p550-ib/ib-of-device
http://ned.rcac.purdue.edu/p550-ib/lspci-v

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
