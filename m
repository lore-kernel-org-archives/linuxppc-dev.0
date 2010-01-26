Return-Path: <Dan.Geer@faa.gov>
Received: from relay1.faa.gov (relay1.faa.gov [204.108.10.6])
	by ozlabs.org (Postfix) with ESMTP id 1848AB7D4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jan 2010 07:41:14 +1100 (EST)
Subject: BSE-IP
MIME-Version: 1.0
From: Dan.Geer@faa.gov
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OF3B9B44C2.CF12E7DB-ON852576B7.0070B35D-852576B7.0070B371@faa.gov>
Date: Tue, 26 Jan 2010 15:30:59 -0500
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


My end goal is to run the latest 2.6.32 kernel on an ancient BSE-IP MPC823
board.  One step in the process is an attempt to compile the last "working"
kernel for this platform, and it hasn't been pretty.

Back in 2005, Kumar Gala caught an issue with compiling for this platform,
and Dan Malek commented about which options to choose to complete a
successful compile.  I'm in the process of trying to get that (2.6.16.62)
series to work.  It seems that one of the newer dev boards got the focus of
the port, and the BSE-IP drop out of sight.

Is anyone still working with the BSE-IP?  What is the last known working
kernel?  Any suggestions/insight into what kernel works would be very much
appreciated.

Dan
