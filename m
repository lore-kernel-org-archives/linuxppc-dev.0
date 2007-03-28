Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 18:19:24 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [RFC 0/3] powerpc: Add Motorola PrPMC2800 platform support
Message-ID: <20070328011924.GA1586@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This set of patches adds support for Motorola ECC PrPMC280/PrPMC2800
platform.  The PrPMC280 sits on an F101 baseboard and the PrPMC2800
sits on a F101e baseboard.  Logic has been added to determine which
board (and variant thereof) the code is being run on.

They are based on the patches in the thread with the subject: 
  "[RFC 0/8] powerpc: Add initial arch/powerpc support for Marvell/mv64x60"

Mark
