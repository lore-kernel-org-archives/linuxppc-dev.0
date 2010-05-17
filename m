Return-Path: <wg@grandegger.com>
Message-ID: <4BF163B8.9070509@grandegger.com>
Date: Mon, 17 May 2010 17:41:44 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v3 3/3] ptp: Added a clock that uses the eTSEC found on
	the MPC85xx.
References: <cover.1273855016.git.richard.cochran@omicron.at>
	<ee6c3edca3ee6aa86565e59da999375f79c9de1b.1273855017.git.richard.cochran@omicron.at>
In-Reply-To: <ee6c3edca3ee6aa86565e59da999375f79c9de1b.1273855017.git.richard.cochran@omicron.at>
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

On 05/14/2010 06:46 PM, Richard Cochran wrote:
> The eTSEC includes a PTP clock with quite a few features. This patch adds
> support for the basic clock adjustment functions, plus two external time
> stamps and one alarm.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Tested-by: Wolfgang Grandegger <wg@denx.de>

on my Freescale MPC8313 setup with ptpd and ptpv2d.

FYI: checkplatch.pl reports various errors for this patch series.

Wolfgang.
