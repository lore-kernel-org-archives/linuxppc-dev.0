Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 21 Jul 2011 10:59:09 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Ayman Elkhashab <aymane@elkhashab.com>
Subject: Re: [v3 PATCH 1/1] powerpc/4xx: enable and fix pcie gen1/gen2 on the
	460sx
Message-ID: <20110721005909.GN20597@ozlabs.org>
References: <1310603611-8960-2-git-send-email-ayman@elkhashab.com>
	<1311166949-2543-1-git-send-email-aymane@elkhashab.com>
	<1311166949-2543-2-git-send-email-aymane@elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1311166949-2543-2-git-send-email-aymane@elkhashab.com>
Cc: Ayman El-Khashab <ayman@elkhashab.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 20, 2011 at 08:02:29AM -0500, Ayman Elkhashab wrote:
> From: Ayman El-Khashab <ayman@elkhashab.com>
> 
> Adds a register to the config space for the 460sx.  Changes the vc0
> detect to a pll detect.  maps configuration space to test the link
> status.  changes the setup to enable gen2 devices to operate at gen2
> speeds.  fixes mapping that was not correct for the 460sx.  added
> bit definitions for the OMRxMSKL registers.  Removed reserved bit
> that was set incorrectly in the OMR2MSKL register.

FWIW Looks good to me.

Yours Tony
