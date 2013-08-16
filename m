Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 5F5852C0259
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 19:41:12 +1000 (EST)
Message-ID: <520DF3BD.2070904@arm.com>
Date: Fri, 16 Aug 2013 10:41:17 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Jonas Bonn <jonas@southpole.se>
Subject: Re: [RFC PATCH 2/4] openrisc: remove undefined of_get_cpu_node
 declaration
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1376586580-5409-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/08/13 18:09, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>=20
> This patch removes the declaration of the function 'of_get_cpu_node'
> which is not defined for openrisc. This is in preparation to move
> it's definition from PPC to DT common code.
>=20
> Again it could be there as it was originally copied from powerpc.
>=20
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Cc: Jonas Bonn <jonas@southpole.se>
Hi Jonas,

Since both microblaze and openrisc have moderated lists which I am not
member of, these patches were blocked. Michal Simek agreed to remove
this for microblaze. Do you see any concern with this patch for openrisc
? Can I have you ACK if it looks fine ?

Regards,
Sudeep
> ---
>  arch/openrisc/include/asm/prom.h | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/openrisc/include/asm/prom.h b/arch/openrisc/include/asm=
/prom.h
> index bbb34e5..eb59bfe 100644
> --- a/arch/openrisc/include/asm/prom.h
> +++ b/arch/openrisc/include/asm/prom.h
> @@ -44,9 +44,6 @@ void of_parse_dma_window(struct device_node *dn, const =
void *dma_window_prop,
> =20
>  extern void kdump_move_device_tree(void);
> =20
> -/* CPU OF node matching */
> -struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
> -
>  /* Get the MAC address */
>  extern const void *of_get_mac_address(struct device_node *np);
> =20
>=20
