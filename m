Return-Path: <wg@grandegger.com>
Message-ID: <4B449EB0.5090107@grandegger.com>
Date: Wed, 06 Jan 2010 15:31:12 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] can: mscan-mpc5xxx: add support for the
	Freescale MPC512x
References: <1262719241-2422-1-git-send-email-wg@grandegger.com>
In-Reply-To: <1262719241-2422-1-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Socketcan-core@lists.berlios.de, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> This patch series adds support for the MPC512x from Freescale to
> the mpc5xxx_can MSCAN driver.
> 
> Changes since v1:
> 
> - Various coding style issues, printk formats, variable names and
>   error messagaes and typos fixes or improved
> 
> - MPC5xxx specific data are now passed to mpc5xxx_can_probe() via
>   "of_device_id->data".
> 
> - The index of the MPC512x CAN controller is now derived directly
>   from reg property. This allows use of_iomap() as usual.
> 
> - It has been documented that MPC512x Rev.1 CPUs are not supported.

As you might have already realized, this patch set slipped out
accidentally to the mailing list due to a bug in my
patch-format-test-and-send-email script. Nevertheless, it's good enough
for reviewing and testing. Just some debugging code needs to be removed.
Wolfram, is it OK from your point of view now? I will roll out v3 after
some  more thorough testing tomorrow.

Wolfgang.
