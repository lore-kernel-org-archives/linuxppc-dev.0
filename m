Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "Cisco Appliance Demo Certificate",
 Issuer "Cisco Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 918AF2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 19:44:08 +1000 (EST)
Message-ID: <1370252643.11717.27.camel@zakaz.uk.xensource.com>
Subject: Re: DTB build failure due to preproccessing
From: Ian Campbell <Ian.Campbell@citrix.com>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 3 Jun 2013 10:44:03 +0100
In-Reply-To: <CACxGe6vWtofRb3ysPueJ73e3O18vNegiLapcTg_JZ9eRmPL5BA@mail.gmail.com>
References: <1369996170.5199.68.camel@zakaz.uk.xensource.com>
 <20130531114824.60D223E0901@localhost> <51A8CA15.4070504@wwwdotorg.org>
 <CACxGe6vWtofRb3ysPueJ73e3O18vNegiLapcTg_JZ9eRmPL5BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Michal Marek <mmarek@suse.cz>, JonLoeliger <jdl@jdl.com>, Stephen
 Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 linux-kbuild@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-31 at 17:31 +0100, Grant Likely wrote:
> On Fri, May 31, 2013 at 5:04 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 05/31/2013 05:48 AM, Grant Likely wrote:
> >> ---
> >> commit d01dccdcb3ea8233b09efb9c24db9f057fbd3b37
> >> Author: Grant Likely <grant.likely@linaro.org>
> >> Date:   Fri May 31 12:45:18 2013 +0100
> >>
> >>     dtc: Suppress cpp linemarker annotations
> >>
> >>     DTC isn't able to parse cpp linemarker annotations, so suppress them in
> >>     the cpp output by adding the -P flag to the cpp options.
> >
> > That's not true; it explicitly does have code to parse the line markers.
> > I'll have to investigate why it isn't working in this case.
> >
> > If you apply this patch, then anyone who has switched to #include rther
> > than /include/ will get incorrect line numbers in dtc error messages.
> > Admittedly that's a smaller population right now though. Perhaps we
> > should just do a kernel-wide conversion though.
> 
> My mistake. I tested the wrong thing. I've dropped the patch.

FWIW I've also dropped it from my device-tree.git tree.

Ian.
