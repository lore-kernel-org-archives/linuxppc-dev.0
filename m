Date: Wed, 26 Nov 2003 16:52:38 +0100
From: Peter Vandenabeele <peter.vandenabeele@mind.be>
To: Jon Masters <jonathan@jonmasters.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: ppc4xx Ports]
Message-ID: <20031126165238.O7373@mind.be>
Reply-To: Peter Vandenabeele <peter.vandenabeele@mind.be>
References: <3FB416F9.7080303@jonmasters.org> <20031114002023.GA9509@gate.ebshome.net> <3FB423AB.80805@jonmasters.org> <20031114004805.GA9585@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031114004805.GA9585@gate.ebshome.net>; from ebs@ebshome.net on Thu, Nov 13, 2003 at 04:48:05PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 13, 2003 at 04:48:05PM -0800, Eugene Surovegin wrote:
[...]
> I don't have any PTE/TLB related problems on 405GP/405GPr.

On the PowerPC 405 in the Virtex-II Pro, we needed to turn off
half of the TLB entries as per "Solution 12" on
http://support.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=1&iCountryID=1&getPagePath=14052

"... Limit TLB depth to 32 entries by only using even entries in the TLB ...."

Peter

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
