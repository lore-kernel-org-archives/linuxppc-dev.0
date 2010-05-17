Return-Path: <wg@grandegger.com>
Message-ID: <4BF1639F.60900@grandegger.com>
Date: Mon, 17 May 2010 17:41:19 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v3 1/3] ptp: Added a brand new class driver for ptp clocks.
References: <cover.1273855016.git.richard.cochran@omicron.at>
	<aa2a85799677c08001b152c2921d0e55d5693ffa.1273855017.git.richard.cochran@omicron.at>
In-Reply-To: <aa2a85799677c08001b152c2921d0e55d5693ffa.1273855017.git.richard.cochran@omicron.at>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2010 06:45 PM, Richard Cochran wrote:
> This patch adds an infrastructure for hardware clocks that implement
> IEEE 1588, the Precision Time Protocol (PTP). A class driver offers a
> registration method to particular hardware clock drivers. Each clock is
> exposed to user space as a character device with ioctls that allow tuning
> of the PTP clock.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Tested-by: Wolfgang Grandegger <wg@denx.de>

on my Freescale MPC8313 setup with ptpd and ptpv2d.

Wolfgang.
