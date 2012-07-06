Return-Path: <B29396@freescale.com>
Date: Fri, 6 Jul 2012 17:13:36 +0800
From: Dong Aisheng <b29396@freescale.com>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 1/1] of: reform prom_update_property function
Message-ID: <20120706091335.GB28264@shlinux2.ap.freescale.net>
References: <1340605714-25206-1-git-send-email-b29396@freescale.com>
 <4FE8F6DA.8070109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FE8F6DA.8070109@gmail.com>
Cc: "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2012 at 07:40:10AM +0800, Rob Herring wrote:
> On 06/25/2012 01:28 AM, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > prom_update_property() currently fails if the property doesn't
> > actually exist yet which isn't what we want. Change to add-or-update
> > instead of update-only, then we can remove a lot duplicated lines.
> > 
> > Suggested-by: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> Ben, you can merge this via powerpc.
> 
> Rob
> 
Ping...

Regards
Dong Aisheng
