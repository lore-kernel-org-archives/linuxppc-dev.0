Return-Path: <michael@ellerman.id.au>
Date: Thu, 25 Jul 2013 13:17:18 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Feed entire flattened device tree into the
 random pool
Message-ID: <20130725031717.GB15673@concordia>
References: <20130725125122.78accf44@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130725125122.78accf44@kryten>
Cc: devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 12:51:22PM +1000, Anton Blanchard wrote:
> 
> We feed the entire DMI table into the random pool to provide
> better random data during early boot, so do the same with the
> flattened device tree.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> It might be worth doing this somewhere common, but the only place
> I could find (unflatten_device_tree) is almost certainly too
> early in the boot process.

Nice.

But why not put the initcall in drivers/of/fdt.c, that way it's not
early but it's still common ?

cheers
