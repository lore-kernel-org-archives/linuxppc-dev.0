Return-Path: <wg@grandegger.com>
Message-ID: <4E451B20.2070207@grandegger.com>
Date: Fri, 12 Aug 2011 14:22:56 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v12 5/6] flexcan: Prefer device tree clock frequency if
	available.
References: <1313138752-24006-1-git-send-email-holt@sgi.com>
	<1313138752-24006-6-git-send-email-holt@sgi.com>
In-Reply-To: <1313138752-24006-6-git-send-email-holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>, socketcan-core@lists.berlios.de,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2011 10:45 AM, Robin Holt wrote:
> If our CAN device's device tree node has a clock-frequency property,
> then use that value for the can devices clock frequency.  If not, fall
> back to asking the platform/mach code for the clock frequency associated
> with the flexcan device.
> 
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Kumar Gala <galak@kernel.crashing.org>
> To: Wolfgang Grandegger <wg@grandegger.com>,
> To: Marc Kleine-Budde <mkl@pengutronix.de>,
> To: U Bhaskar-B22300 <B22300@freescale.com>
> To: Scott Wood <scottwood@freescale.com>
> To: Grant Likely <grant.likely@secretlab.ca>
> Cc: socketcan-core@lists.berlios.de,
> Cc: netdev@vger.kernel.org,
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> Cc: devicetree-discuss@lists.ozlabs.org

Acked-by: Wolfgang Grandegger <wg@grandegger.com>

>From the Socket-CAN point of view, this and the other patches can go in.
Thanks for your effort.

Wolfgang.
